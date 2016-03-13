FactoryGirl.define do
  sequence :login do |n|
    "login#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :phone do |n|
    "123456#{n}"
  end

  sequence :name do |n|
    "name #{n}"
  end

  sequence :index do |n|
    n
  end

  sequence :description do |n|
    "description description description #{n}"
  end

  factory :user do
    first_name 'Ivan'
    last_name  'Reshetnikov'
    patronymic 'Alexandrovich'
    login { generate :login }
    password '343434'
    role 'student'
    email { generate :email }
    phone { generate :phone }

    factory :student do
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

  factory :mark_track do
    name 5
    comment 'Excellent'
  end

  factory :lesson do
    group_id { generate :index }
    user_id { generate :index }
    subject_id { generate :index }
    auditory_id { generate :index }
    time Time.new 2016, 2, 22, 15, 20
  end

  factory :auditory do
    name { generate :name }
    description { generate :description }
  end

  factory :group do
    name { generate :name }
    description { generate :description }
  end

  factory :subject do
    name { generate :name }
    description { generate :description }
  end
end