class Driveday < ApplicationRecord
  belongs_to :drive
  validates :day_of_week, presence: true
end
