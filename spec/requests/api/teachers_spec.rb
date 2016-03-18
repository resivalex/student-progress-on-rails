require 'rails_helper.rb'

describe 'Teachers API' do
  shared_examples 'teacher record' do
    its(['id']) { should eq teacher.id }
    its(['firstName']) { should eq teacher.first_name }
    its(['lastName']) { should eq teacher.last_name }
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
      it { expect(subject[0]['id']).to eq teachers[0].id }
      it { expect(subject.map {|a| a['id']}).to match_array teachers.map(&:id) }
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

  describe 'GET /teachers/:teacher_id/marks' do
    context '2 teachers, 3 marks, 4 tracks' do
      let!(:lesson1) { FactoryGirl.create :lesson }
      let!(:lesson2) { FactoryGirl.create :lesson, teacher: lesson1.teacher }
      let!(:lesson3) { FactoryGirl.create :lesson }
      let!(:mark1) { FactoryGirl.create :mark, lesson: lesson1 }
      let!(:mark2) { FactoryGirl.create :mark, lesson: lesson2 }
      let!(:mark3) { FactoryGirl.create :mark, lesson: lesson3 }
      let!(:track1) { FactoryGirl.create :mark_track, mark: mark1 }
      let!(:track2) { FactoryGirl.create :mark_track, mark: mark2, created_at: 1.minute.ago }
      let!(:track3) { FactoryGirl.create :mark_track, mark: mark2 }
      let!(:track4) { FactoryGirl.create :mark_track, mark: mark3 }

      it 'lists last tracks' do
        get "/teachers/#{lesson1.teacher.id}/marks.json"
        expect(json.map{|a| a['id']}).to match_array [mark1.id, mark2.id]
      end
    end
  end
end