class Student < ActiveRecord::Base
	belongs_to :user
	belongs_to :group, inverse_of: :students

  validates :user, presence: true
  validates :group, presence: true

  scope :by_group, -> (group_id) { where(group_id: group_id) }
end
