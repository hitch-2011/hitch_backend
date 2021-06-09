require 'rails_helper'

RSpec.describe 'Api::V1::Users::Friends Create', type: :request do
  describe 'happy path' do
    it 'should return a profile when a friend is created with valid user_ids with updated friend status' do
      user1 = User.create(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      vehicle1 = Vehicle.create(make: 'Hyundai', model: 'Sonata', year: '2013', user_id: user1.id)
      user2 = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      ride = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user2.id )
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride.id)
      user3 = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      reciever_params = {reciever_id: user2.id }
      post "/api/v1/users/#{user1.id}/friends?reciever_id=#{user2.id}", params: reciever_params
      profile_details = JSON.parse(response.body, symbolize_names: true)
      expect(profile_details).to be_a(Hash)
      check_hash_structure(profile_details[:data], :attributes, Hash)
      check_hash_structure(profile_details[:data], :id, String)
      expect(profile_details[:data][:id]).to eq("#{user2.id}")
      check_hash_structure(profile_details[:data], :type, String)
      expect(profile_details[:data][:type]).to eq("profile")
      check_hash_structure(profile_details[:data][:attributes], :email, String)
      check_hash_structure(profile_details[:data][:attributes], :fullname, String)
      expect(profile_details[:data][:attributes][:email]).to eq("#{user2.email}")
      expect(profile_details[:data][:attributes][:fullname]).to eq("#{user2.fullname}")
      check_hash_structure(profile_details[:data][:attributes], :email, String)
      check_hash_structure(profile_details[:data][:attributes], :bio, String)
      expect(profile_details[:data][:attributes][:bio]).to eq("#{user2.bio}")
      expect(profile_details[:data][:attributes][:friendship_status]).to eq(["pending", Friend.first.id])
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
  end
end
