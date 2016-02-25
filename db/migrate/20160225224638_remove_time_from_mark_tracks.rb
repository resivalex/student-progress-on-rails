class RemoveTimeFromMarkTracks < ActiveRecord::Migration
  def change
    remove_column :mark_tracks, :time, :timestamp
  end
end
