require 'rails_helper.rb'

describe 'Marks API' do
  let!(:lesson) { FactoryGirl.create :lesson }
  let!(:student) { FactoryGirl.create :student }
  let!(:mark_data) do
    {
      mark: '4',
      comment: '1, 2, 3, 4',
      studentId: student.id,
      lessonId: lesson.id
    }
  end

  shared_context 'one mark' do
    let!(:mark) { FactoryGirl.create :mark, lesson: lesson, student: student }
    let!(:mark_track) { FactoryGirl.create :mark_track, mark: mark }
  end

  describe 'POST /marks' do
    context 'no marks' do
      before do
        post '/marks', mark_data
      end

      it 'creates mark' do
        expect(Mark.count).to eq 1
      end

      it 'adds track' do
        expect(MarkTrack.count).to eq 1
      end

      it 'links track' do
        expect(MarkTrack.take.mark_id).to eq Mark.take.id
      end
    end

    context 'mark exists already' do
      include_context 'one mark'

      before do
        post '/marks.json', mark_data
      end

      it 'doesn\'t create mark' do
        expect(Mark.count).to eq 1
      end

      it 'adds track' do
        expect(MarkTrack.count).to eq 2
      end
    end
  end

  describe 'GET /marks' do
    context 'no marks' do
      before { get '/marks.json' }

      it 'renders empty array' do
        expect(json.length).to eq 0
      end
    end

    context 'one mark' do
      include_context 'one mark'

      before { get '/marks.json' }

      subject { json[0] }

      it { expect(json.length).to eq 1 }
      its(['id']) { should eq mark.id }
      its(['mark']) { should eq mark_track.name }
      its(['comment']) { should eq mark_track.comment }
      its(['lessonId']) { should eq mark.lesson_id }
      its(['studentId']) { should eq mark.student_id }
    end
  end

  describe 'GET /marks/:id' do
    context 'no marks' do
      it 'not found' do
        get '/marks/1.json'
        expect(response).to be_not_found
      end
    end

    context 'one mark' do
      include_context 'one mark'

      it 'not found' do
        get "/marks/#{mark.id + 1}.json"
        expect(response).to be_not_found
      end

      describe 'retrieves element' do
        before { get "/marks/#{mark.id}.json" }

        subject { json }

        it { expect(response).to be_success }
        its(['id']) { should be_nil }
        its(['mark']) { should eq mark_track.name }
        its(['comment']) { should eq mark_track.comment }
        its(['lessonId']) { should eq mark.lesson_id }
        its(['studentId']) { should eq mark.student_id }
      end
    end
  end

  describe 'GET /marks/:id/tracks' do
    context 'one mark' do
      include_context 'one mark'

      before { get "/marks/#{mark.id}/tracks.json" }

      subject { json[0] }
      it { expect(response).to be_success }
      it { expect(json.length).to eq 1 }

      its(['id']) { should be_nil }
      its(['mark']) { should eq mark_track.name }
      its(['comment']) { should eq mark_track.comment }
      its(['datetime']) { should eq mark_track.api_time }
    end
  end
end