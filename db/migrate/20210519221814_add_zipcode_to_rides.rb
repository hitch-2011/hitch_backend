class AddZipcodeToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :zipcode, :string
  end
end
