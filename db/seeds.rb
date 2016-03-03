# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create({
  first_name: 'Ivan',
  last_name: 'Reshetnikov',
  patronymic: 'Alexandrovich',
  login: 'resivalex',
  password: '343434',
  email: 'ivan@example.com',
  role: 'student',
  phone: '343434',
})

User.create({
  first_name: 'Ivan',
  last_name: 'Reshetnikov',
  patronymic: 'Alexandrovich',
  login: 'admin',
  password: '343434',
  email: 'ivan2@example.com',
  role: 'admin',
  phone: '3434343',
})