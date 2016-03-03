class Student < ActiveRecord::Base
	has_one :user
	belongs_to :group, inverse_of: :students
end
