describe Student do
  describe '.by_group' do
    include_context '3 students in 2 groups'

    it 'group with one student' do
      expect(Student.by_group(groups[0].id).size).to eq 1
    end

    it 'group with two students' do
      expect(Student.by_group(groups[1].id).size).to eq 2
    end
  end
end