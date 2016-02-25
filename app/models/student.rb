class Student < ActiveRecord::Base
	has_one :user
	belong_to :group, inverse_of: :students
end
