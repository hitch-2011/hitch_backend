class Fixzipcode < ActiveRecord::Migration[5.2]
  def change
    rename_column :rides, :zipcode, :zipcode_origin
  end
end
