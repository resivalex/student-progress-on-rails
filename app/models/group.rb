require 'name_description_api_convertion'

class Group < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true, length: { maximum: 16 }
	validates :description, length: { maximum: 200 }

	has_many :students, inverse_of: :group
	has_many :lessons, inverse_of: :group

  include NameDescriptionApiConvertion;
end
