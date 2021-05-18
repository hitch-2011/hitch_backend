require 'rails_helper'

RSpec.describe "Users API Endpoints" do
  describe "User Details" do
    it 'should return user details details based on id' do
    user1 = User.create!(email: "dominic@gmail.com", password: "password", about_me: "I like driving.")
    user2 = User.create!(email: "jake@gmail.com", password: "password", about_me: "I like driving.")
    user3 = User.create!(email: "cydnee@gmail.com", password: "password", about_me: "I like driving.")
    friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
    friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
    @ride = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user1.id )
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
      expect(profile_details[:data][:attributes][:email]).to eq("#{user1.email}")
      check_hash_structure(profile_details[:data][:attributes], :email, String)
      check_hash_structure(profile_details[:data][:attributes], :about_me, String)
      expect(profile_details[:data][:attributes][:about_me]).to eq("#{user1.about_me}")
      check_hash_structure(profile_details[:data][:attributes], :rides, Hash)
      check_hash_structure(profile_details[:data][:attributes][:rides], :data, Array)
      profile_details[:data][:attributes][:rides][:data].each do |ride|
        expect(ride[:id]).to eq("#{@ride.id}")
        expect(ride[:type]).to eq("ride")
        expect(ride[:attributes][:origin]).to eq("#{@ride.origin}")
        expect(ride[:attributes][:destination]).to eq("#{@ride.destination}")
        expect(ride[:attributes][:departure_time]).to eq("#{@ride.departure_time}")
        check_hash_structure(ride[:attributes], :origin, String)
        check_hash_structure(ride[:attributes], :destination, String)
        check_hash_structure(ride[:attributes], :departure_time, String)
        check_hash_structure(ride[:attributes], :user_id, Integer)
      end
    check_hash_structure(profile_details[:data][:attributes][:friends], :data, Array)
    check_hash_structure(profile_details[:data][:attributes], :friends, Hash)
      profile_details[:data][:attributes][:friends][:data].each do |ref|
        check_hash_structure(ref[:attributes], :email, String)
        check_hash_structure(ref[:attributes], :about_me, String)
        check_hash_structure(ref, :type, String)
        check_hash_structure(ref, :id, String)
      end
    end

    it 'still works with less less than 1 ride or friend' do
      user1 = User.create!(email: "dominic@gmail.com", password: "password", about_me: "I like driving.")
      user2 = User.create!(email: "jake@gmail.com", password: "password", about_me: "I like driving.")
      user3 = User.create!(email: "cydnee@gmail.com", password: "password", about_me: "I like driving.")
      get "/api/v1/users/#{user1.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:data][:attributes][:rides][:data]).to be_an(Array)
      expect(profile_details[:data][:attributes][:friends][:data]).to be_an(Array)
      expect(profile_details[:data][:attributes][:friends][:data].empty?).to eq(true)
      expect(profile_details[:data][:attributes][:friends][:data].empty?).to eq(true)
    end

    it 'allows for multiple rides' do
      user1 = User.create!(email: "dominic@gmail.com", password: "password", about_me: "I like driving.")
      user2 = User.create!(email: "jake@gmail.com", password: "password", about_me: "I like driving.")
      user3 = User.create!(email: "cydnee@gmail.com", password: "password", about_me: "I like driving.")
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      trip = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user1.id )
      trip2 = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user3.id )
      get "/api/v1/users/#{user1.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:data][:attributes][:rides][:data]).to be_an(Array)
      expect(profile_details[:data][:attributes][:rides][:data].count).to eq(2)
    end


    it 'does not grab other rides' do
      user1 = User.create!(email: "dominic@gmail.com", password: "password", about_me: "I like driving.")
      user2 = User.create!(email: "jake@gmail.com", password: "password", about_me: "I like driving.")
      user3 = User.create!(email: "cydnee@gmail.com", password: "password", about_me: "I like driving.")
      user4= User.create!(email: "differnt@gmail.com", password: "password", about_me: "I like driving.")
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      trip = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user1.id )
      trip2 = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user3.id )
      trip3 = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user2.id )
      trip4 = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user4.id )
      get "/api/v1/users/#{user1.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:data][:attributes][:rides][:data]).to be_an(Array)
      expect(profile_details[:data][:attributes][:rides][:data].count).to eq(3)
    end

    it 'does not grab other rides' do
      user1 = User.create!(email: "dominic@gmail.com", password: "password", about_me: "I like driving.")
      user2 = User.create!(email: "jake@gmail.com", password: "password", about_me: "I like driving.")
      user3 = User.create!(email: "cydnee@gmail.com", password: "password", about_me: "I like driving.")
      user4= User.create!(email: "differnt@gmail.com", password: "password", about_me: "I like driving.")
      user5 = User.create!(email: "new@gmail.com", password: "password", about_me: "I like driving.")
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user5.id)
      trip = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user1.id )
      trip2 = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user3.id )
      trip3 = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user2.id )
      trip4 = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user4.id )
      trip5 = Ride.create!(origin: "origin", destination: "destination", departure_time: "9:00am", user_id: user5.id )

      get "/api/v1/users/#{user1.id}"
      expect(response).to be_successful
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:data][:attributes][:rides][:data]).to be_an(Array)
      expect(profile_details[:data][:attributes][:rides][:data].count).to eq(4)
    end
  end



  describe 'sad path' do
    it 'breaks without properly formatted id' do
      user1 = User.create!(email: "dominic@gmail.com", password: "password", about_me: "I like driving.")
      user2 = User.create!(email: "jake@gmail.com", password: "password", about_me: "I like driving.")
      user3 = User.create!(email: "cydnee@gmail.com", password: "password", about_me: "I like driving.")
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      get "/api/v1/users/one"
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:message]).to eq("your request cannot be completed")
      expect(profile_details[:error]).to eq("String not accepted as id")
    end

    it 'breaks if the id does not exist' do
      user1 = User.create!(email: "dominic@gmail.com", password: "password", about_me: "I like driving.")
      get "/api/v1/users/1000000000000"
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:error]).to eq("Couldn't find User with 'id'=1000000000000")
    end

    it 'breaks when it is empty string' do
      user1 = User.create!(email: "dominic@gmail.com", password: "password", about_me: "I like driving.")
      get "/api/v1/users/''"
      profile_details = JSON.parse(response.body, symbolize_names:true)
      expect(profile_details[:message]).to eq("your request cannot be completed")
      expect(profile_details[:error]).to eq("String not accepted as id")
    end
  end
end
