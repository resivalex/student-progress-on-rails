RSpec.describe 'Marks API' do
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
    context 'when unauthorized' do
      before { post '/marks', mark_data }

      it_behaves_like 'private resource'
    end

    context 'when authorized' do
      include_context 'authorized teacher'

      context 'no marks' do
        before { post '/marks', mark_data }

        it 'creates mark' do
          expect(Mark.count).to eq 1
          expect(Mark.take.lesson_id).to eq mark_data[:lessonId]
          expect(Mark.take.student_id).to eq mark_data[:studentId]
        end

        it 'adds track' do
          expect(MarkTrack.count).to eq 1
          expect(MarkTrack.take.name).to eq mark_data[:mark]
          expect(MarkTrack.take.comment).to eq mark_data[:comment]
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
  end

  describe 'GET /marks/:id' do
    context 'when unauthorized' do
      include_context 'one mark'

      before { get "/marks/#{mark.id}.json" }

      it_behaves_like 'private resource'
    end

    context 'when authorized' do
      include_context 'authorized teacher'

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

          it { expect(response).to be_success }

          subject { json }
          its(['id'])         { should be_nil }
          its(['mark'])       { should eq mark_track.name }
          its(['comment'])    { should eq mark_track.comment }
          its(['lessonId'])   { should eq mark.lesson_id }
          its(['studentId'])  { should eq mark.student_id }
        end
      end
    end
  end

  describe 'GET /marks/:id/tracks' do
    include_context 'one mark'

    context 'when unauthorized' do
      before { get "/marks/#{mark.id}/tracks.json" }

      it_behaves_like 'private resource'
    end

    context 'when authorized' do
      include_context 'authorized teacher'

      context 'one mark' do
        before { get "/marks/#{mark.id}/tracks.json" }

        it { expect(response).to be_success }
        it { expect(json.length).to eq 1 }

        subject { json[0] }
        its(['id'])       { should be_nil }
        its(['mark'])     { should eq mark_track.name }
        its(['comment'])  { should eq mark_track.comment }
        its(['datetime']) { should eq mark_track.api_time }
      end
    end
  end
end