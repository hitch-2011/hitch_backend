require 'rails_helper'

RSpec.describe Rideday, type: :model do
  describe 'relationships' do
    it {should belong_to :ride}
  end

  describe 'validations' do
    it {should validate_presence_of :day_of_week}
  end

  it 'downcases all the days of week' do
    dominic  = User.create!(fullname: "Dominic", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
    ride3    = Ride.create!(origin: "8659 E Wesley Dr, Denver, CO 80231, USA", destination: "1832 S Ivanhoe St, Denver, CO 80224, USA", departure_time: "9:00am", user_id: dominic.id )
    rideday3 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
    downcased = dominic.rides.first.ridedays.first.day_of_week
    expect(downcased).to eq("monday")

  end
end
