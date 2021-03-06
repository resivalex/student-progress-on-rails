class Lesson < ActiveRecord::Base
	belongs_to :group, inverse_of: :lessons
	belongs_to :subject, inverse_of: :lessons
	belongs_to :auditory, inverse_of: :lessons
	belongs_to :teacher, class_name: 'User', foreign_key: 'user_id'

	has_many :marks

	validates :group, presence: true
	validates :subject, presence: true
	validates :auditory, presence: true
	validates :teacher, presence: true
	validates :time, presence: true

	validate :time_multiple_by_five_munutes?

	def time_multiple_by_five_munutes?
		unless time.nil?
			unless time.sec == 0 and time.min % 5 == 0
				errors.add(:time, "isn't multiple 5 minutes")
			end
		end
	end

	def to_api
		{
			id: id,
			groupId: group_id,
			subjectId: subject_id,
			auditoryId: auditory_id,
			teacherId: user_id,
			datetime: time.iso8601
		}
	end

	def from_api data
		send :group_id=, data[:groupId]
		send :subject_id=, data[:subjectId]
		send :auditory_id=, data[:auditoryId]
		send :user_id=, data[:teacherId]
		send :time=, data[:datetime]
		self
	end

	def api_time
		time.iso8601
	end

	def rich_struct
		h = {
			id: id,
			group_id: group_id,
			group: group.name,
			subject_id: subject_id,
			subject: subject.name,
			auditory_id: auditory_id,
			auditory: auditory.name,
			teacher_id: user_id,
			teacher: teacher.last_name,
			time: api_time
		}
		OpenStruct.new h
	end

	def self.to_api
		Lesson.all.map(&:rich_struct)
	end
end
