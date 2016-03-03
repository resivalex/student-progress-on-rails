require 'rails_helper.rb'

describe Admin::UsersController do
  before do
    admin = FactoryGirl.create :admin
    cookies[:user_id] = admin.id
  end
end