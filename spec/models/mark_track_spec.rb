describe MarkTrack do
  describe '.last_by_mark_id' do
    context '2 marks with tracks' do
      let!(:mark1) { FactoryGirl.create :mark }
      let!(:mark2) { FactoryGirl.create :mark }
      let!(:tracks1) do
        [
          FactoryGirl.create(:mark_track, mark: mark1, created_at: 1.minute.ago),
          FactoryGirl.create(:mark_track, mark: mark1, created_at: Time.new),
          FactoryGirl.create(:mark_track, mark: mark1, created_at: 2.minute.ago),
        ]
      end
      let!(:tracks2) do
        [
          FactoryGirl.create(:mark_track, mark: mark2, created_at: Time.new),
          FactoryGirl.create(:mark_track, mark: mark2, created_at: 3.minute.ago)
        ]
      end

      it 'first mark' do
        expect(MarkTrack.last_by_mark_id(mark1.id).id).to eq tracks1[1].id
      end

      it 'second mark' do
        expect(MarkTrack.last_by_mark_id(mark2.id).id).to eq tracks2[0].id
      end

      it 'absent mark' do
        expect(MarkTrack.last_by_mark_id([mark1.id, mark2.id].max + 1)).to be_nil
      end
    end
  end
end