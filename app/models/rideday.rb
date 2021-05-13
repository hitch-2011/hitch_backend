class Rideday < ApplicationRecord
  belongs_to :ride
  validates :day_of_week, presence: true
end
