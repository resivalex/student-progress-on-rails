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

    context 'when unauthorized' do
      before { get '/users.json' }

      it_behaves_like 'private resource'
    end

    context 'when authorized' do
      include_context 'authorized admin'

      before { get '/users.json' }

      it { expect(response).to be_success }
      it { expect(json.length).to eq 2 }

      subject { json.find{ |i| i['id'] == user.id } }
      it_behaves_like 'user record'
    end
  end

  describe 'GET /users/:id.json' do
    let!(:user) { FactoryGirl.create :user }

    context 'when unauthorized' do
      before { get "/users/#{user.id}.json" }

      it_behaves_like 'private resource'
    end

    context 'when authorized' do
      include_context 'authorized admin'

      before { get "/users/#{user.id}.json" }

      it { expect(response).to be_success }

      subject { json }
      it_behaves_like 'user record'
    end
  end

  describe 'POST /users.json' do
    let!(:user) { FactoryGirl.build :user }
    let(:data) do
      data = user.to_api
      data[:password] = 'password'
      data
    end

    context 'when unauthorized' do
      before { post '/users.json', data }

      it_behaves_like 'private resource'
    end

    context 'when authorized' do
      include_context 'authorized admin'

      before { post '/users.json', data }

      it { expect(response).to be_success }

      it { expect(User.count).to eql 2 }
      # it { expect(User.take.first_name).to eql data[:firstName] }
    end
  end

  describe 'PUT /users/:id.json' do
    let!(:user) { FactoryGirl.create :user }
    let!(:old_password_digest) { user.password_digest }
    let!(:data) do
      data = user.to_api
      data[:firstName] += '_'
      data[:password] = 'new password'
      data
    end

    context 'when unauthorized' do
      before { put "/users/#{user.id}.json", data }

      it_behaves_like 'private resource'
    end

    context 'when authorized' do
      include_context 'authorized admin'

      context 'password not empty' do
        before { put "/users/#{user.id}.json", data }

        it { expect(response).to be_success }
        it { expect(User.count).to eql 2 }
        it { expect(user.reload.first_name).to eq data[:firstName] }
        it { expect(user.reload.password_digest).to_not eq old_password_digest }
      end

      context 'password empty' do
        let!(:data_with_empty_password) do
          data2 = data
          data2[:password] = ''
          data2
        end

        before { put "/users/#{user.id}.json", data_with_empty_password }

        it { expect(User.count).to eql 2 }
        it { expect(user.reload.first_name).to eql data[:firstName] }
        it { expect(user.reload.password_digest).to eq old_password_digest }
      end
    end
  end

  describe 'DELETE /users/:id.json' do
    let!(:user) { FactoryGirl.create :user }

    context 'when unauthorized' do
      before { delete "/users/#{user.id}.json" }

      it_behaves_like 'private resource'
    end

    context 'when authorized' do
      include_context 'authorized admin'

      before { delete "/users/#{user.id}.json" }

      it { expect(User.count).to eql 1 }
    end
  end
end