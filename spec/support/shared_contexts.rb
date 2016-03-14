RSpec.shared_context '2 students, admin and teacher' do
  let!(:students) { FactoryGirl.create_list :student_user, 2 }
  let!(:admin) { FactoryGirl.create :admin }
  let!(:teacher) { FactoryGirl.create :teacher }
end

RSpec.shared_context '3 students in 2 groups' do
    let!(:groups) { FactoryGirl.create_list :group, 2 }
    let!(:one_student) { FactoryGirl.create :student, group: groups[0] }
    let!(:two_students) { FactoryGirl.create_list :student, 2, group: groups[1] }
end