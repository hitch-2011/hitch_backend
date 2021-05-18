class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true
  enum status: [:default, :pending, :denied, :approved]
end
