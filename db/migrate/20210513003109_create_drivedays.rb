class CreateDrivedays < ActiveRecord::Migration[5.2]
  def change
    create_table :drivedays do |t|
      t.references :drives, foreign_key: true
      t.string :day_of_week

      t.timestamps
    end
  end
end
