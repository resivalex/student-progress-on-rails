class Lesson < ActiveRecord::Base
	validate :time_multiple_by_five_munutes?

	belongs_to :group, inverse_of: :lessons
	belongs_to :subject, inverse_of: :lessons
	belongs_to :auditory, inverse_of: :lessons
	belongs_to :teacher, class_name: 'User', foreign_key: 'user_id'

	def time_multiple_by_five_munutes?
		unless time.sec == 0 and time.min % 5 == 0
			errors.add(:time, "isn't multiple 5 minutes")
		end
	end

	def to_api
		{
			id: id,
			groupId: group_id,
			subjecId: subject_id,
			auditoryId: auditory_id,
			teacherId: user_id
		}
	end

	def from_api data
		send :group_id=, data[:groupId]
		send :subject_id=, data[:subjectId]
		send :auditory_id=, data[:auditoryId]
		send :user_id=, data[:teacherId]
	end

	def api_time
		time.iso8601
	end
end
