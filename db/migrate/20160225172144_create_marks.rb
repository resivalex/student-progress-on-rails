class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.references :student, index: true, foreign_key: true
      t.references :lesson, index: true, foreign_key: true
    end
  end
end
