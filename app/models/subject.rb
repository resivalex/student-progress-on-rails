require 'name_description_api_convertion'

class Subject < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
	validates :description, length: { maximum: 200 }

	has_many :lessons, inverse_of: :subject

  include NameDescriptionApiConvertion
end
