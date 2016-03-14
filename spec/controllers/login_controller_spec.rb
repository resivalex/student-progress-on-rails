require "rails_helper"

describe LoginController do
  let(:user) { FactoryGirl.create :user }

  it 'saves user to cookies' do
    post :index, { login: user.login, password: user.password }
    expect(cookies[:user_id]).to eql user.id
  end
end