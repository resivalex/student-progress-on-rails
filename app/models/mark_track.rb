class MarkTrack < ActiveRecord::Base
	MARKS = %w(2 3 4 5 н)

	validates :name, presence: true, inclusion: { in: MARKS }
	validates :comment, length: { maximum: 200 }

	belongs_to :mark, inverse_of: :mark_tracks, dependent: :destroy
end
