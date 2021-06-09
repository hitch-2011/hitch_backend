require 'rails_helper'

RSpec.describe 'Api::V1::Users::Friends Create', type: :request do
  describe 'happy path' do
    it 'should destroy the friend resource when hit and return the profile information with add friendship_status' do
      user1 = User.create(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      vehicle1 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user1.id)
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      ride = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user2.id )
      friend = Friend.create!(requestor_id: user2.id, receiver_id: user1.id, status: 0)
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride.id)
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")

      delete "/api/v1/users/#{user1.id}/friends/#{friend.id}"

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a(Hash)
      expect(data[:message]).to be_a("Friendship denied.")


    end

  end
end
