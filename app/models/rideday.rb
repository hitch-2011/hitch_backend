class Rideday < ApplicationRecord
  belongs_to :ride
  validates :day_of_week, presence: true
  before_save { day_of_week.try(:downcase!) }
end
