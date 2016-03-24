RSpec.shared_context 'authorized user' do |role|
  before do
    password = 'sdgsdklepow'
    user = FactoryGirl.create role, password: password
    post '/session', email: user.email, password: password
  end
end

RSpec.shared_context 'authorized admin' do
  include_context 'authorized user', :admin
end

RSpec.shared_context 'authorized teacher' do
  include_context 'authorized user', :teacher
end