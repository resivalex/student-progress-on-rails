RSpec.describe Lesson do
  describe '#to_api' do
    let(:lesson) { FactoryGirl.build :lesson }

    subject { lesson.to_api }

    its([:id])        { should eq lesson.id }
    its([:groupId])   { should eq lesson.group_id }
    its([:teacherId]) { should eq lesson.user_id }
    its([:subjectId]) { should eq lesson.subject_id }
    its([:datetime])  { should eq lesson.api_time }
  end

  describe '#from_api' do
    let(:lesson) { FactoryGirl.build :lesson }

    subject { Lesson.new.from_api lesson.to_api }

    its(:group_id)    { should eq lesson.group_id }
    its(:user_id)     { should eq lesson.user_id }
    its(:subject_id)  { should eq lesson.subject_id }
    its(:time)        { should eq lesson.time }
  end
end