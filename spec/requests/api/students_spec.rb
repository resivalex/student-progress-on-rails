require 'rails_helper.rb'

describe 'Subjects API' do
  include_context '2 students, admin and teacher'

  describe 'POST /students' do
    let!(:student_user) { students[0] }
    let!(:group) { FactoryGirl.create :group }

    let(:data) do
      {
        userId: student_user.id,
        groupId: group.id
      }
    end

    before { post '/students.json', data }

    it { expect(response).to be_success }
    it { expect(Student.count).to eq 1 }

    subject { Student.take }
    its(:group_id) { should eq group.id }
    its(:user_id) { should eq student_user.id }
  end

  describe 'GET /students' do
    before { get '/students.json' }

    it { expect(json.length).to eq 2 }

    it 'contains full set' do
      expect(json.map{|i|i['id']}).to match_array students.map(&:id)
    end
  end

  describe 'GET /students/:id' do
    describe 'existing student' do
      let!(:student_user) { students[0] }
      let!(:student) { FactoryGirl.create :student, user: student_user }

      before { get "/students/#{student_user.id}.json" }

      it { expect(response).to be_success }

      subject { json }
      its(['groupId']) { should eq student.group_id }
      its(['firstName']) { should eq student_user.first_name }
      its(['lastName']) { should eq student_user.last_name }
      its(['patronymic']) { should eq student_user.patronymic }
    end

    describe 'not student' do
      before { get "/students/#{admin.id}.json" }

      it { expect(response).to be_not_found }
    end
  end
end
