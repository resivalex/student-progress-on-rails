RSpec.describe 'Teachers API' do
  shared_examples 'teacher record' do
    its(['id'])         { should eq teacher.id }
    its(['firstName'])  { should eq teacher.first_name }
    its(['lastName'])   { should eq teacher.last_name }
    its(['patronymic']) { should eq teacher.patronymic }
  end

  describe 'GET /teachers' do
    subject { json }

    context 'no teachers' do
      before { get '/teachers' }

      its(:length) { should eq 0 }
    end

    context 'one teacher' do
      let!(:teacher) { FactoryGirl.create :teacher }

      before { get '/teachers' }

      it { expect(json.length).to eq 1 }

      subject { json[0] }
      it_behaves_like 'teacher record'
    end

    context '2 teachers' do
      let!(:teachers) { FactoryGirl.create_list :teacher, 2 }
      let!(:amdin) { FactoryGirl.create :admin }

      before { get '/teachers' }

      its(:length) { should eq 2 }
      it { expect(json[0]['id']).to eq teachers[0].id }
      it { expect(json.map {|a| a['id']}).to match_array teachers.map(&:id) }
    end
  end

  describe 'GET /teachers/:id' do
    context 'one teacher' do
      let!(:teacher) { FactoryGirl.create :teacher }

      before { get "/teachers/#{teacher.id}.json" }

      subject { json }
      it_behaves_like 'teacher record'
    end
  end
end