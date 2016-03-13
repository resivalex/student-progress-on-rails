require 'rails_helper.rb'

describe 'Users API' do
  it '#index' do
    FactoryGirl.create :user

    get '/users.json'

    expect(response).to be_success

    expect(json.length).to eq 1
  end

  it '#show' do
    user = FactoryGirl.create :user
    get "/users/#{user.id}.json"

    expect(response).to be_success

    expect(json['firstName']).to eq user.first_name
    expect(json['password']).to be_nil
  end

  it '#create' do
    user = FactoryGirl.build :user
    data = user.to_api

    post '/users.json', data

    user = User.take

    expect(User.count).to eql 1
    expect(user.first_name).to eql data[:firstName]
  end

  it '#update' do
    user = FactoryGirl.create :user
    data = user.to_api
    data[:firstName] += '_'

    put "/users/#{user.id}.json", data

    expect(User.count).to eql 1
    expect(User.take.first_name).to eql data[:firstName]
  end

  it '#destroy' do
    user = FactoryGirl.create :user

    delete "/users/#{user.id}.json"

    expect(User.count).to eql 0
  end
end