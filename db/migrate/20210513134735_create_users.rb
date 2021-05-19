class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :about_me
      t.string :fullname
      t.timestamps
    end
  end
end
