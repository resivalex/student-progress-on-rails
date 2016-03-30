RSpec.describe 'Authorization' do
  let(:email)     { 'mail@example.com' }
  let(:password)  { 'pa55w0rD' }
  let!(:user)     { FactoryGirl.create :user, email: email, password: password }

  describe 'POST /session' do
    before { post '/session', email: email, password: password }

    it 'saves user to session' do
      expect(session[:user_id]).to eql User.find_by_email(email).id
    end
  end

  describe 'DELETE /session' do
    before do
      post '/session', email: email, password: password
      delete '/session'
    end

    it 'deletes user from session' do
      expect(session[:user_id]).to be_nil
    end
  end

  after { session[:user_id] = nil }
end