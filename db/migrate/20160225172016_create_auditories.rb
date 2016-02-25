class CreateAuditories < ActiveRecord::Migration
  def change
    create_table :auditories do |t|
      t.string :name
      t.text :description
    end
  end
end
