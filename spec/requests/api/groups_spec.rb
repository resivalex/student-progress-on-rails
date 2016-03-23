RSpec.describe 'Groups API' do
  it_behaves_like 'name-description resource',
    resource: 'groups',
    factory_name: :group,
    model: Group

  describe '/groups/:id/students' do
    include_context '3 students in 2 groups'

    describe 'wrong group id' do
      before { get '/groups/wrong_id/students.json' }

      it { expect(response).to be_not_found }
    end

    context 'group with one student' do
      before { get "/groups/#{groups[0].id}/students.json" }

      it { expect(response).to be_success }
      it { expect(json.length).to eq 1 }

      subject { json[0] }
      its(['id']) { should be_present }
      its(['firstName']) { should be_present }
    end

    context 'group with two students' do
      before { get "/groups/#{groups[1].id}/students.json" }

      it { expect(response).to be_success }
      it { expect(json.length).to eq 2 }
    end
  end
end
