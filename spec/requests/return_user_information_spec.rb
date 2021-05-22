require 'rails_helper'

RSpec.describe "Users API Endpoints" do
  describe "User Details" do
    it 'should return user details details based on id' do
    user1 = User.create(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
    vehicle1 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user1.id)
    user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
    user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
    friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
    friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
    @ride = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
    rideday = Rideday.create!(day_of_week: 'Monday', ride_id: @ride.id)
    rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: @ride.id)
    rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: @ride.id)
      get "/api/v1/users/#{user1.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details).to be_a(Hash)
      check_hash_structure(profile_details[:data], :attributes, Hash)
      check_hash_structure(profile_details[:data], :id, String)
      expect(profile_details[:data][:id]).to eq("#{user1.id}")
      check_hash_structure(profile_details[:data], :type, String)
      expect(profile_details[:data][:type]).to eq("profile")
      check_hash_structure(profile_details[:data][:attributes], :email, String)
      check_hash_structure(profile_details[:data][:attributes], :fullname, String)
      expect(profile_details[:data][:attributes][:email]).to eq("#{user1.email}")
      expect(profile_details[:data][:attributes][:fullname]).to eq("#{user1.fullname}")
      check_hash_structure(profile_details[:data][:attributes], :email, String)
      check_hash_structure(profile_details[:data][:attributes], :bio, String)
      expect(profile_details[:data][:attributes][:bio]).to eq("#{user1.bio}")
      check_hash_structure(profile_details[:data][:attributes], :user_rides, Array)
      profile_details[:data][:attributes][:user_rides].each do |ride|
        expect(ride[:id]).to be_a(Numeric)
        expect(ride[:user_id]).to be_a(Numeric)
        expect(ride[:origin]).to be_a(String)
        expect(ride[:destination]).to be_a(String)
        expect(ride[:departure_time]).to be_a(String)
        expect(ride[:zipcode_origin]).to be_a(String)
        expect(ride[:zipcode_destination]).to be_a(String)
      end
    end

    it 'still works with less less than 1 ride or friend' do
      user1 = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      vehicle1 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user1.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      @ride = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: @ride.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: @ride.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: @ride.id)
      get "/api/v1/users/#{user1.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:data][:attributes][:user_rides]).to be_an(Array)
      expect(profile_details[:data][:attributes][:user_rides].count).to eq(1)
      expect(profile_details[:data][:attributes][:matched_rides][0].empty?).to eq(true)
      expect(profile_details[:data][:attributes][:matched_rides][1].empty?).to eq(true)
    end

    it 'allows for multiple rides' do
      user1 = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      trip = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      trip2 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user3.id )
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: trip.id)
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: trip2.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: trip.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: trip2.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: trip.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: trip2.id)
      get "/api/v1/users/#{user1.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:data][:attributes][:matched_rides]).to be_an(Array)
      expect(profile_details[:data][:attributes][:matched_rides].count).to eq(2)
    end


    it 'does not grab other rides' do
      user1 = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      user4= User.create!(fullname: "fullname", email: "differnt@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      trip = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      trip2 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user3.id )
      trip3 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user2.id )
      trip4 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user4.id )
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: trip.id)
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: trip2.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: trip.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: trip2.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: trip.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: trip2.id)
      get "/api/v1/users/#{user1.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:data][:attributes][:matched_rides]).to be_an(Array)
      expect(profile_details[:data][:attributes][:matched_rides].count).to eq(2)
    end

    it 'does not grab other rides' do
      user1 = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      user4= User.create!(fullname: "fullname", email: "differnt@gmail.com", password: "password", bio: "I like driving.")
      user5 = User.create!(fullname: "fullname", email: "new@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user5.id)
      trip = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      trip2 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user3.id )
      trip3 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user2.id )
      trip4 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user4.id )
      trip5 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user5.id )

      get "/api/v1/users/#{user1.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:data][:attributes][:matched_rides]).to be_an(Array)
      expect(profile_details[:data][:attributes][:matched_rides].count).to eq(3)
    end
  end



  describe 'sad path' do
    it 'breaks without properly formatted id' do
      user1 = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      get "/api/v1/users/one"
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:message]).to eq("your request cannot be completed")
      expect(profile_details[:error]).to eq("String not accepted as id")
    end

    it 'breaks if the id does not exist' do
      user1 = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      get "/api/v1/users/1000000000000"
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:error]).to eq("Couldn't find User with 'id'=1000000000000")
    end

    it 'breaks when it is empty string' do
      user1 = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      get "/api/v1/users/''"
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:message]).to eq("your request cannot be completed")
      expect(profile_details[:error]).to eq("String not accepted as id")
    end
  end
end
