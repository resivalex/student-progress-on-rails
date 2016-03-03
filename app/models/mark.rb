class Mark < ActiveRecord::Base
	belongs_to :lesson
	has_many :mark_tracks, -> { order 'created_at asc' }
end
