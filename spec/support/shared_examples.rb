RSpec.shared_examples "name-description resource" do |options|
  it '#index' do
    object = FactoryGirl.create options[:factory_name]

    get "/#{options[:resource]}.json"

    expect(response).to be_success

    expect(json.length).to eq 1
    expect(json[0]['name']).to eq object.name
  end

  it '#show' do
    object = FactoryGirl.create options[:factory_name]
    get "/#{options[:resource]}/#{object.id}.json"

    expect(response).to be_success
    expect(json['name']).to eq object.name
  end

  it '#create' do
    data = FactoryGirl.build(options[:factory_name]).to_api

    post "/#{options[:resource]}.json", data

    object = options[:model].take

    expect(options[:model].count).to eq 1
    expect(object.name).to eq data[:name]
  end

  it '#update' do
    data = FactoryGirl.create(options[:factory_name]).to_api
    data[:name] += '_'

    put "/#{options[:resource]}/#{data[:id]}.json", data

    expect(options[:model].count).to eq 1
    expect(options[:model].take.name).to eq data[:name]
  end

  it '#destroy' do
    object = FactoryGirl.create options[:factory_name]

    delete "/#{options[:resource]}/#{object.id}.json"

    expect(options[:model].count).to eq 0
  end
end
