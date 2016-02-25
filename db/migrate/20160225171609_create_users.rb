class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :patronymic
      t.string :login
      t.string :password
      t.string :role
      t.string :email
      t.string :phone
    end
  end
end
