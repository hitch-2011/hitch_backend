class Friend < ApplicationRecord
  belongs_to :receiver, class_name: :User
  belongs_to :requestor, class_name: :User

  validates :receiver_id, presence: true
  validates :requestor_id, presence: true
  enum status: [:pending, :approved]
end
