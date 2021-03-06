RSpec.describe Mark do
  describe '#to_api' do
    let(:mark_track)  { FactoryGirl.create :mark_track }
    let(:mark)        { mark_track.mark }

    subject { mark.to_api }

    its([:id])        { should eq mark.id }
    its([:mark])      { should eq mark_track.name }
    its([:comment])   { should eq mark_track.comment }
    its([:lessonId])  { should eq mark.lesson_id }
    its([:studentId]) { should eq mark.student_id }
  end

  describe '#from_api' do
    let(:mark_track)  { FactoryGirl.create :mark_track }
    let(:mark)        { mark_track.mark }

    subject { Mark.new.from_api mark.to_api }

    its(:lesson_id)   { should eq mark.lesson_id }
    its(:student_id)  { should eq mark.student_id }
  end
end
