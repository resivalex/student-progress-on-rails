FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :phone do |n|
    "123456#{n}"
  end

  sequence :name do |n|
    "name #{n}"
  end

  sequence :description do |n|
    "description description description #{n}"
  end

  factory :user do
    first_name 'Ivan'
    last_name  'Reshetnikov'
    patronymic 'Alexandrovich'
    password '343434'
    role 'student'
    email
    phone

    factory :student_user do
      role 'student'
    end

    factory :admin do
      role 'admin'
    end

    factory :teacher do
      role 'teacher'
    end

    factory :chief do
      role 'chief'
    end
  end

  factory :student do
    group
    association :user, factory: :student_user
  end

  factory :mark_track do
    mark
    name 5
    comment 'Excellent'
  end

  factory :lesson do
    group
    teacher
    subject
    auditory
    time Time.new 2016, 2, 22, 15, 20
  end

  factory :auditory do
    name
    description
  end

  factory :group do
    name
    description

    factory :with_students do
      transient do
        students_count 2
      end

      before(:create) do |group, evaluator|
        create_list :student, evaluator.students_count
      end
    end
  end

  factory :subject do
    name
    description
  end

  factory :mark do
    student
    lesson
  end
end