class Student < ActiveRecord::Base
	belongs_to :user
	belongs_to :group, inverse_of: :students

  validates :user, presence: true
  validates :group, presence: true

  scope :by_group, -> (group_id) { where(group_id: group_id) }

  def self.by_id_to_api id
    query = <<-SQL
      SELECT users.id AS id, group_id, first_name, last_name, patronymic
      FROM users
      LEFT OUTER JOIN students ON users.id = students.user_id
      WHERE role = 'student'
    SQL
    students = ActiveRecord::Base.connection.execute query
    students = students.select{ |s| s['id'].to_s == id }

    student = students.first
    if student
      f = student
      s = {
        group_id: f['group_id'],
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
end
