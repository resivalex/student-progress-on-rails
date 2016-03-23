RSpec.describe 'Users API' do
  shared_examples 'user record' do
    its(['firstName'])  { should eq user.first_name }
    its(['lastName'])   { should eq user.last_name }
    its(['patronymic']) { should eq user.patronymic }
    its(['email'])      { should eq user.email }
    its(['password'])   { should be_nil }
    its(['phone'])      { should eq user.phone }
  end

  describe 'GET /users.json' do
    let!(:user) { FactoryGirl.create :user }

    before { get '/users.json' }

    it { expect(response).to be_success }
    it { expect(json.length).to eq 1 }

    subject { json[0] }
    it_behaves_like 'user record'
  end

  describe 'GET /users/:id.json' do
    let!(:user) { FactoryGirl.create :user }

    before { get "/users/#{user.id}.json" }

    it { expect(response).to be_success }

    subject { json }
    it_behaves_like 'user record'
  end

  describe 'POST /users.json' do
    let!(:user) { FactoryGirl.build :user }
    let(:data) do
      data = user.to_api
      data[:password] = 'password'
      data
    end

    before { post '/users.json', data }

    it { expect(User.count).to eql 1 }
    it { expect(User.take.first_name).to eql data[:firstName] }
  end

  describe 'PUT /users/:id.json' do
    let!(:user) { FactoryGirl.create :user }
    let!(:old_password_digest) { user.password_digest }

    context 'password not empty' do
      let!(:data) do
        data = user.to_api
        data[:firstName] += '_'
        data[:password] = 'new password'
        data
      end

      before { put "/users/#{user.id}.json", data }

      it { expect(response).to be_success }
      it { expect(User.count).to eql 1 }
      it { expect(User.take.first_name).to eq data[:firstName] }
      it { expect(User.take.password_digest).to_not eq old_password_digest }
    end

    context 'password empty' do
      let!(:data) do
        data = user.to_api
        data[:firstName] += '_'
        data[:password] = ''
        data
      end

      before { put "/users/#{user.id}.json", data }

      it { expect(User.count).to eql 1 }
      it { expect(User.take.first_name).to eql data[:firstName] }
      it { expect(User.take.password_digest).to eq old_password_digest }
    end
  end

  describe 'DELETE /users/:id.json' do
    let!(:user) { FactoryGirl.create :user }

    before { delete "/users/#{user.id}.json" }

    it { expect(User.count).to eql 0 }
  end
end