require 'rails_helper'

RSpec.describe 'Api::V1::Users Show', type: :request do
  describe "User Details" do
    it 'should return user details of your own profile' do
      user1 = User.create(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      vehicle1 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user1.id)
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(requestor_id: user1.id, receiver_id: user2.id, status: 1)
      friend2 = Friend.create!(requestor_id: user1.id, receiver_id: user3.id, status: 1)
      @ride = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: @ride.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: @ride.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: @ride.id)
      get "/api/v1/users/#{user1.id}?profile_id=#{user1.id}"
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
      expect(profile_details[:data][:attributes][:friendship_status]).to eq("self")
      expect(profile_details[:data][:attributes][:vehicle].first[:id]).to eq(vehicle1.id)
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
    it 'should return other persons info and add with no friendship request made yet' do
      user1 = User.create(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      vehicle1 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user1.id)
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      
      @ride = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: @ride.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: @ride.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: @ride.id)
      get "/api/v1/users/#{user1.id}?profile_id=#{user2.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      
      expect(profile_details[:data][:attributes][:friendship_status]).to eq("add")
    end
    it 'should return other persons info and pending if logged in user requested friendship' do
      user1 = User.create(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      vehicle1 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user1.id)
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(requestor_id: user1.id, receiver_id: user2.id)
      @ride = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: @ride.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: @ride.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: @ride.id)
      get "/api/v1/users/#{user1.id}?profile_id=#{user2.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      
      expect(profile_details[:data][:attributes][:friendship_status]).to eq("pending")
    end
    it 'should return other persons info and approve/deny if logged in user received friendship request' do
      user1 = User.create(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      vehicle1 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user1.id)
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(requestor_id: user2.id, receiver_id: user1.id)
      @ride = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: @ride.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: @ride.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: @ride.id)
      get "/api/v1/users/#{user1.id}?profile_id=#{user2.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      
      expect(profile_details[:data][:attributes][:friendship_status]).to eq("approve/deny")
    end
    it 'should return other persons info and approved if friendship is approved' do
      user1 = User.create(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      vehicle1 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user1.id)
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(requestor_id: user2.id, receiver_id: user1.id, status: 1)
      @ride = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: @ride.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: @ride.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: @ride.id)
      get "/api/v1/users/#{user1.id}?profile_id=#{user2.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      
      expect(profile_details[:data][:attributes][:friendship_status]).to eq("approved")
    end
  end

  describe 'sad path' do
    it 'breaks without properly formatted id' do
      user1 = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(requestor_id: user1.id, receiver_id: user2.id)
      friend = Friend.create!(requestor_id: user1.id, receiver_id: user3.id)
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
