class Lesson < ActiveRecord::Base
	validate :time_multiple_by_five_munutes?

	belong_to :group, inverse_of: :lessons
	belong_to :subject, inverse_of: :lessons
	belong_to :auditory, inverse_of: :lessons
	belong_to :teacher, class_name: 'User', foreign_key: 'user_id'

	def time_multiple_by_five_munutes?
		unless time.sec == 0 and time.min % 5 == 0
			errors.add(:time, "isn't multiple 5 minutes")
		end
	end
end
