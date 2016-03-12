require 'rails_helper.rb'

describe 'Users API' do
  it 'lists users' do
    FactoryGirl.create :user

    get '/users.json'

    expect(response).to be_success

    expect(json.length).to eq 1
  end

  it 'retrieves user' do
    user = FactoryGirl.create :user
    get "/users/#{user.id}.json"

    expect(response).to be_success

    expect(json['firstName']).to eq user.first_name
    expect(json['password']).to be_nil
  end

  it 'creates user' do
    user = FactoryGirl.build :user
    data = user.to_api

    post '/users.json', data

    user = User.take

    expect(User.count).to eql 1
    expect(user.first_name).to eql data[:firstName]
  end

  it 'updates user' do
    user = FactoryGirl.create :user
    data = user.to_api
    data[:firstName] += '_'

    put "/users/#{user.id}.json", data

    expect(User.count).to eql 1
    expect(User.take.first_name).to eql data[:firstName]
  end

  it 'deletes user' do
    user = FactoryGirl.create :user

    delete "/users/#{user.id}.json"

    expect(User.count).to eql 0
  end

  it 'not found' do
    get '/users/notfound.json'

    expect(response.status).to eql 404
  end
end