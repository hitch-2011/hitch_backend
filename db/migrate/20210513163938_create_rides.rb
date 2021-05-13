class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.references :user, foreign_key: true
      t.string :origin
      t.string :destination
      t.string :departure_time

      t.timestamps
    end
  end
end
