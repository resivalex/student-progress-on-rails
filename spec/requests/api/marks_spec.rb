require 'rails_helper.rb'

describe 'Marks API' do
  describe 'POST /marks' do
    let!(:lesson) { FactoryGirl.create :lesson }
    let!(:student) { FactoryGirl.create :student }

    context 'no marks' do
      before do
        post '/marks', {
          mark: '4',
          comment: '1, 2, 3, 4',
          studentId: student.id,
          lessonId: lesson.id
        }
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
      before do
        FactoryGirl.create :mark_track,
          mark: (FactoryGirl.create :mark,
            lesson: lesson,
            student: student)

        post '/marks', {
          mark: '4',
          comment: '1, 2, 3, 4',
          studentId: student.id,
          lessonId: lesson.id
        }
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