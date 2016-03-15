class MarkTrack < ActiveRecord::Base
	MARKS = %w(2 3 4 5 н)

	validates :name, presence: true, inclusion: { in: MARKS }
	validates :comment, length: { maximum: 200 }

	belongs_to :mark, inverse_of: :mark_tracks, dependent: :destroy

  scope :by_mark_id, -> (mark_id) { where(mark_id: mark_id).order(:created_at) }

  def self.last_by_mark_id mark_id
    by_mark_id(mark_id).last
  end

  def api_time
    created_at.iso8601
  end

  def to_api
    {
      mark: name,
      comment: comment,
      datetime: api_time
    }
  end
end
