class CreateMarkTracks < ActiveRecord::Migration
  def change
    create_table :mark_tracks do |t|
      t.string :name
      t.references :mark, index: true, foreign_key: true
      t.timestamp :time
      t.text :comment
    end
  end
end
