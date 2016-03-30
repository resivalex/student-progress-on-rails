# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[Auditory, Group, Lesson, Subject, User].each &:destroy_all

auditories = Auditory.create [
  {
    name: '100',
    description: 'Первая аудитория'
  },
  {
    name: '101',
    description: 'Вторая аудитория'
  },
  {
    name: '102',
    description: 'Третья аудитория'
  },
]

groups = Group.create [
  {
    name: '0001',
    description: 'Первая группа'
  },
  {
    name: '0002',
    description: 'Вторая группа'
  },
  {
    name: '0003',
    description: 'Третья группа'
  },
]

subjects = Subject.create [
  {
    name: 'Геометрия',
    description: 'Первый предмет'
  },
  {
    name: 'Физика',
    description: 'Второй предмет'
  },
  {
    name: 'История',
    description: 'Третий предмет'
  },
]

users = User.create [
  {
    first_name: 'Иван',
    last_name: 'Решетников',
    patronymic: 'Александрович',
    password: '343434',
    email: 'ivan@example.com',
    role: 'student',
    phone: '343434',
  },
  {
    first_name: 'Василий',
    last_name: 'Васильевич',
    patronymic: 'Васильев',
    password: '123456',
    email: 'admin@example.com',
    role: 'admin',
    phone: '123456',
  },
  {
    first_name: 'Пётр',
    last_name: 'Петров',
    patronymic: 'Петрович',
    password: '654321',
    email: 'petr@example.com',
    role: 'teacher',
    phone: '654321',
  },
  {
    first_name: 'Борис',
    last_name: 'Борисович',
    patronymic: 'Борисов',
    password: '111111',
    email: 'boris@example.com',
    role: 'chief',
    phone: '111111',
  },
]

students = Student.create [
  {
    user: users.first,
    group: groups.first
  }
]

lessons = Lesson.create [
  {
    group: groups.first,
    teacher: users[2],
    subject: subjects.first,
    auditory: auditories.first,
    time: (Time.new 2016, 3, 3, 10, 30, 0)
  }
]

marks = Mark.create [
  {
    student: students.first,
    lesson: lessons.first
  }
]

tracks = MarkTrack.create [
  {
    mark: marks.first,
    name: '5',
    comment: 'Отлично'
  }
]