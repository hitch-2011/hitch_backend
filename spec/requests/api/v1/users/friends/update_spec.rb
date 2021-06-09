require 'rails_helper'

RSpec.describe 'Api::V1::Users::Friends Update', type: :request do 
  describe 'it returns a message if friendship approved' do 
    it 'should return all pending friend records when user is receiver' do 
      user1 = User.create(fullname: "Dominic Padulo", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      vehicle1 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user1.id)
      ride = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      rideday1 = Rideday.create!(day_of_week: 'Monday', ride_id: ride.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride.id)

      user2 = User.create!(fullname: "Jake V", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      vehicle2 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user2.id)
      ride2 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user2.id )
      rideday4 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
      rideday5 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
      rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)

      user3 = User.create!(fullname: "Cydnee S", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      vehicle3 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user3.id)
      ride3 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user3.id )
      rideday7 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
      rideday8 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
      rideday9 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)

      user4 = User.create!(fullname: "Steven M", email: "steven@gmail.com", password: "password", bio: "I like driving.")
      vehicle4 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user4.id)
      ride4 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user4.id )
      rideday10 = Rideday.create!(day_of_week: 'Monday', ride_id: ride4.id)
      rideday11 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride4.id)
      rideday12 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride4.id)

      friend1 = Friend.create!(requestor_id: user2.id, receiver_id: user1.id)
      friend2 = Friend.create!(requestor_id: user3.id, receiver_id: user1.id, status: 1)
      friend3 = Friend.create!(requestor_id: user4.id, receiver_id: user1.id)
      
      expect(friend1.status).to eq("pending")
      patch "/api/v1/users/#{user1.id}/friends/#{friend1.id}"
      body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)
      
      expect(Friend.first.status).to eq("approved")
      check_hash_structure(body, :message, String)
      
    end
  end
end