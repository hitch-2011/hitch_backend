class CreateRidedays < ActiveRecord::Migration[5.2]
  def change
    create_table :ridedays do |t|
      t.references :ride, foreign_key: true
      t.string :day_of_week

      t.timestamps
    end
  end
end
