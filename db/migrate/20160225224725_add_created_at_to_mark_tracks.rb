class AddCreatedAtToMarkTracks < ActiveRecord::Migration
  def change
    add_column :mark_tracks, :created_at, :timestamp
  end
end
