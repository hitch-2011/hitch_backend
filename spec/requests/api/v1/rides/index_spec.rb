# frozen_string_literal: true

require 'rails_helper'


describe 'Rides Index Endpoint' do
  describe 'GET /rides' do
    it 'can fetch all rides' do
      VCR.use_cassette('ride-matcher') do
        user = create(:user).id
        ride = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
        ride2 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80032, USA', user_id: user)
        ride3 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
        ride4 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80247, USA', user_id: user)
        ride5 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80000, USA', user_id: user)
        ride6 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
        rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride.id)
        rideday2 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
        rideday3 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride.id)
        rideday4 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
        rideday5 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride.id)
        rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
        rideday7 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
        rideday8 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
        rideday9 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
        rideday10 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride4.id)
        get "/api/v1/users/#{user}/rides"
        expect(response).to be_successful

        rides = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(rides.count).to eq(3)
        check_hash_structure(rides, :type, String)
        check_hash_structure(rides, :id, String)
        check_hash_structure(rides, :attributes, Hash)
        check_hash_structure(rides[:attributes], :matched_routes, Array)
        matched =  rides[:attributes][:matched_routes]
        matched.each do |match|
          check_hash_structure(match, :departure_time, String)
          check_hash_structure(match, :zipcode_origin, String)
          check_hash_structure(match, :user_id, Integer)
          check_hash_structure(match, :zipcode_destination, String)
          check_hash_structure(match, :zipcode_origin, String)
          check_hash_structure(match, :origin, String)
          check_hash_structure(match, :destination, String)
          check_hash_structure(match, :distance_from_origin, Numeric)
          check_hash_structure(match, :distance_from_destination, Numeric)
          end
        end
      end
    end

      it 'allows for different user rides' do
        VCR.use_cassette('ride-matcher1') do
        user = create(:user).id
        user2 = create(:user).id
        user3 = create(:user).id
        user4 = create(:user).id
        user5 = create(:user).id
        user6 = create(:user).id
        ride = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
        ride2 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80032, USA', user_id: user2)
        ride3 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user3)
        ride4 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80247, USA', user_id: user4)
        ride5 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80000, USA', user_id: user5)
        ride6 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80241, USA', user_id: user6)
        ride7 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80241, USA', user_id: user6)
        rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride.id)
        rideday2 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
        rideday3 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride.id)
        rideday4 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
        rideday5 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride.id)
        rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
        rideday7 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
        rideday8 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
        rideday9 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
        rideday10 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride4.id)
        get "/api/v1/users/#{user}/rides"
        rides = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(response).to be_successful
        matched = rides[:attributes][:matched_routes]
        expect(matched.count).to eq(2)
        expect(matched.count).to eq(2)
      end
    end
  end

  describe 'sad paths' do

    it 'fails when either param is nil' do
      VCR.use_cassette('incorrect_user') do
        user = create(:user).id
        user2 = create(:user).id
        user3 = create(:user).id
        user4 = create(:user).id
        user5 = create(:user).id
        user6 = create(:user).id
        ride = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
        ride2 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80032, USA', user_id: user2)
        ride3 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user3)
        ride4 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80247, USA', user_id: user4)
        ride5 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80000, USA', user_id: user5)
        ride6 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80241, USA', user_id: user6)
        rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride.id)
        rideday2 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
        rideday3 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride.id)
        rideday4 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
        rideday5 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride.id)
        rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
        rideday7 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
        rideday8 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
        rideday9 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
        rideday10 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride4.id)
        get "/api/v1/users/10000000/rides"
        sad = JSON.parse(response.body, symbolize_names: true)
        expect(sad).to eq({:error=>"Couldn't find User with 'id'=10000000"})
      end
    end
    it 'returns something with no matching routes' do
      VCR.use_cassette('no_matches') do
        user = create(:user).id
        user2 = create(:user).id
        user3 = create(:user).id
        user4 = create(:user).id
        user5 = create(:user).id
        user6 = create(:user).id
        ride = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
        ride2 = create(:ride, origin: '1216 Royal Dublin Ln, Dyer, In 46311, USA', destination: '3300 S Tamarac Dr, Denver, CO 80031, USA', user_id: user2)
        ride3 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user3)
        ride4 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80247, USA', user_id: user4)
        ride5 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80000, USA', user_id: user5)
        ride6 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80241, USA', user_id: user6)
        rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride.id)
        rideday2 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
        rideday3 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride.id)
        rideday4 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
        rideday5 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride.id)
        rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
        rideday7 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
        rideday8 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
        rideday9 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
        rideday10 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride4.id)

        get "/api/v1/users/#{user2}/rides"
        rides = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(rides).to eq('You are our first route in those areas! We will find a hitch for you soon!')
    end
  end
end
