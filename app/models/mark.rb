class Mark < ActiveRecord::Base
	belong_to :lesson
	has_many :mark_tracks
end
