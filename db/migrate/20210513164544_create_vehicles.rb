class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.references :user, foreign_key: true
      t.string :make
      t.string :model
      t.string :year

      t.timestamps
    end
  end
end
