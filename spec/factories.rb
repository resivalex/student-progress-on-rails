FactoryGirl.define do
  factory :user do
    first_name 'Ivan'
    last_name  'Reshetnikov'
    patronymic 'Alexandrovich'
    login 'resivalex'
    password '343434'
    email 'ivan@example.com'
    role 'student'
    phone '343434'
  end
end