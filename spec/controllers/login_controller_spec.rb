require "rails_helper"

describe LoginController do
  before do
    @user = FactoryGirl.create :user
  end

  # saves user id in Cookies
  it 'saved user to cookies' do
    post :index, { login: @user.login, password: @user.password }
    expect(cookies[:user_id]).to eql @user.id
  end
end