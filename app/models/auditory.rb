class Auditory < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true, length: { maximum: 16 }
	validates :description, length: { maximum: 200 }

	has_many :lessons, inverse_of: :auditory
end
