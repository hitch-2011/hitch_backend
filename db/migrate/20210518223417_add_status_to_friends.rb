class AddStatusToFriends < ActiveRecord::Migration[5.2]
  def change
    add_column :friends, :status, :integer, default: 0
  end
end
