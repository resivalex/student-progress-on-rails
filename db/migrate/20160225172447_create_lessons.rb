class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :group, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.references :auditory, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamp :time
    end
  end
end
