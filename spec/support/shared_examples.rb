RSpec.shared_examples "name-description resource" do |options|
  model =         options[:model]
  factory_name =  options[:factory_name]
  resource =      options[:resource]

  shared_context 'name-description record' do
    its(['name'])         { should eq object.name }
    its(['description'])  { should eq object.description }
  end

  let(:data) { FactoryGirl.build(factory_name).to_api }

  describe 'GET /#{resource}.json' do
    let!(:object) { FactoryGirl.create factory_name }

    before { get "/#{resource}.json" }

    it { expect(response).to be_success }

    it { expect(json.length).to eq 1 }

    subject { json[0] }
    it_behaves_like 'name-description record'
  end

  describe 'GET /#{resource}/:id.json' do
    let!(:object) { FactoryGirl.create factory_name }

    before { get "/#{resource}/#{object.id}.json" }

    it { expect(response).to be_success }

    subject { json }
    it_behaves_like 'name-description record'
  end

  describe 'POST /#{resource}.json' do
    before { post "/#{resource}.json", data }

    it { expect(model.count).to eq 1 }
    it { expect(model.take.name).to eq data[:name] }
  end

  describe 'PUT /#{resource}/:id.json' do
    let!(:data2) do
      data2 = FactoryGirl.create(factory_name).to_api
      data2[:name] += '_'
      data2
    end

    before { put "/#{resource}/#{data2[:id]}.json", data2 }

    it { expect(model.count).to eq 1 }
    it { expect(model.take.name).to eq data2[:name] }
  end

  describe 'DELETE /#{resource}/:id.json' do
    let!(:object) { FactoryGirl.create factory_name }

    before { delete "/#{resource}/#{object.id}.json" }

    it { expect(model.count).to eq 0 }
  end
end
