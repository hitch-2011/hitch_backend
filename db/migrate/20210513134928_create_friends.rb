class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
        t.references :receiver
        t.references :requestor
        t.timestamps
      end
    add_foreign_key :friends, :users, column: :receiver_id, primary_key: :id
    add_foreign_key :friends, :users, column: :requestor_id, primary_key: :id
  end
end
