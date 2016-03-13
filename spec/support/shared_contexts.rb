RSpec.shared_context '2 students, admin and teacher' do
  before do
    @student1, @student2 = (1..2).map { FactoryGirl.create :student }
    @admin = FactoryGirl.create :admin
    FactoryGirl.create :teacher
  end
end

RSpec.shared_context '3 students in 2 groups' do
  before do
    @groups = (1..2).map { FactoryGirl.create :group }
    @students = (1..3).map do
      student = Student.new
      student.user = FactoryGirl.create :student
      student
    end
    @students[0].group = @groups[0]
    @students[1].group = @groups[1]
    @students[2].group = @groups[1]
    @students.each(&:save)
  end
end