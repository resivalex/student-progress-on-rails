class Student < ActiveRecord::Base
	belongs_to :user
	belongs_to :group, inverse_of: :students

  validates :user, presence: true
  validates :group, presence: true

  scope :by_group, -> (group_id) { where(group_id: group_id) }

  def self.by_id_to_api id
    query = <<-SQL
      SELECT users.id AS id, group_id, first_name, last_name, patronymic, groups.name AS group_name
      FROM users
      LEFT OUTER JOIN students ON users.id = students.user_id
      JOIN groups ON students.group_id = groups.id
      WHERE role = 'student'
    SQL
    students = ActiveRecord::Base.connection.execute query
    students = students.select{ |s| s['id'].to_s == id }

    student = students.first
    if student
      f = student
      s = {
        group_id: f['group_id'],
        group: f['group_name'],
        first_name: f['first_name'],
        last_name: f['last_name'],
        patronymic: f['patronymic'],
      }
      student = OpenStruct.new s
    end
  end

  def self.students_by_lesson_to_api lesson_id
    lesson = Lesson.find_by_id lesson_id
    if lesson
      by_group(lesson.group_id).map do |student|
        mark_id = 5
        mark = Mark.where(student_id: student.id).where(lesson_id: lesson_id).take
        mark_id = nil
        mark_name = nil
        mark_comment = nil
        if mark
          mark_id = mark.id
          track = MarkTrack.by_mark_id(mark_id).last
          mark_name = track.name
          mark_comment = track.comment
        end
        student_user = student.user
        s = {
          id: student.id,
          mark_id: mark_id,
          mark_name: mark_name,
          mark_comment: mark_comment,
          first_name: student_user.first_name,
          last_name: student_user.last_name,
          patronymic: student_user.patronymic,
        }
        OpenStruct.new s
      end
    else
      []
    end
  end

  def self.students_to_api
    User.students.map do |s|
      group_id = nil
      group_name = nil
      student = Student.where(user_id: s.id).take
      if student
        group_id = student.group_id
        group_name = student.group.name
      end
      h = {
        id: s.id,
        first_name: s.first_name,
        last_name: s.last_name,
        patronymic: s.patronymic,
        group_id: group_id,
        group: group_name
      }
      OpenStruct.new h
    end
  end

  def self.reassign student_id, group_id
    student = Student.where(user_id: student_id).take
    if student
      student.group_id = group_id
      student.save
    else
      false
    end
  end
end
