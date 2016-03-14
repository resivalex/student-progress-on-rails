class Mark < ActiveRecord::Base
	belongs_to :lesson
  belongs_to :student
	has_many :mark_tracks, -> { order 'created_at asc' }

  def to_api
    mark = MarkTrack.last_by_mark_id id
    {
      id: id,
      mark: mark.name,
      comment: mark.comment,
      studentId: student_id,
      lessonId: lesson_id
    }
  end

  def from_api data
    send :lesson_id=, data[:lessonId]
    send :student_id=, data[:studentId]
    self
  end

  def self.add data
    lesson_id = data[:lessonId]
    student_id = data[:studentId]

    if Lesson.exists?(lesson_id) && Student.exists?(student_id)
      mark = Mark.where(lesson_id: lesson_id).where(student_id: student_id).take
      mark ||= Mark.create do |m|
        m.lesson_id = lesson_id
        m.student_id = student_id
      end
      MarkTrack.create do |t|
        t.name = data[:mark]
        t.comment = data[:comment]
        t.mark_id = mark.id
      end
      true
    else
      false
    end
  end
end
