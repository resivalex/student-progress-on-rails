RSpec.describe Student do
  describe '.by_group' do
    include_context '3 students in 2 groups'

    context 'group with one student' do
      let(:group) { groups[0] }
      subject     { Student.by_group(group.id) }

      its(:size)  { should eq 1 }
    end

    context 'group with two students' do
      let(:group) { groups[1] }
      subject     { Student.by_group(group.id) }

      its(:size)  { should eq 2 }
    end
  end
end