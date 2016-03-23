RSpec.describe MarkTrack do
  describe '.last_by_mark_id' do

    subject { -> (id) { MarkTrack.last_by_mark_id id } }

    context '2 marks with tracks' do
      let!(:mark1)  { FactoryGirl.create :mark }
      let!(:mark2)  { FactoryGirl.create :mark }
      let!(:now)    { Time.now.round 0 }
      let!(:tracks1) do
        [
          FactoryGirl.create(:mark_track, mark: mark1, created_at: 1.day.ago),
          FactoryGirl.create(:mark_track, mark: mark1, created_at: now),
          FactoryGirl.create(:mark_track, mark: mark1, created_at: 2.day.ago),
        ]
      end
      let!(:tracks2) do
        [
          FactoryGirl.create(:mark_track, mark: mark2, created_at: now),
          FactoryGirl.create(:mark_track, mark: mark2, created_at: 3.day.ago)
        ]
      end

      context 'mark1' do
        it 'returns last track' do
          expect(subject.call(mark1.id).created_at).to eq now
        end
      end

      context 'mark2' do
        it 'returns last track' do
          expect(subject.call(mark2.id).created_at).to eq now
        end
      end

      context 'absent mark' do
        it 'returns nil' do
          expect(subject.call([mark1.id, mark2.id].max + 1)).to be_nil
        end
      end
    end
  end
end