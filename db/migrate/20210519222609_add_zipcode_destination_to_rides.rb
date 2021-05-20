class AddZipcodeDestinationToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :zipcode_destination, :string
  end
end
