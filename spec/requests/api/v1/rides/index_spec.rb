# frozen_string_literal: true

require 'rails_helper'


describe 'Rides Index Endpoint' do
  describe 'GET /rides' do
    it 'can fetch all rides' do
      VCR.use_cassette('ride-matcher') do
        user = create(:user).id
        ride = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user)
        ride2 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80032, USA', user_id: user)
        ride3 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user)
        ride4 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80247, USA', user_id: user)
        ride5 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80000, USA', user_id: user)
        ride6 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user)

        get "/api/v1/users/#{user}/rides?origin=#{ride.origin}&destination=#{ride.destination}"
        expect(response).to be_successful

        rides = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(rides.count).to eq(1)

        rides.each do |ride|
          check_hash_structure(ride, :type, String)

          ride_details = ride[:attributes]
          check_hash_structure(ride_details, :origin_addr, String)
          check_hash_structure(ride_details, :destination_addr, String)
          check_hash_structure(ride_details, :original_user_id, String)
          check_hash_structure(ride_details, :distance_from_origin, Array)
          check_hash_structure(ride_details, :distance_from_destination, Array)
          check_hash_structure(ride_details, :matched_rides, Hash)
          expect(ride_details[:matched_rides][:data].count).to eq(3)
          ride_details[:matched_rides][:data].each do |matched|
            check_hash_structure(matched, :id, String)
            check_hash_structure(matched, :type, String)
            check_hash_structure(matched, :attributes, Hash)
            attributes = matched[:attributes]
            check_hash_structure(attributes, :origin, String)
            check_hash_structure(attributes, :destination, String)
            check_hash_structure(attributes, :departure_time, String)
            check_hash_structure(attributes, :user_id, Integer)
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
        ride = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user)
        ride2 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80032, USA', user_id: user2)
        ride3 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user3)
        ride4 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80247, USA', user_id: user4)
        ride5 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80000, USA', user_id: user5)
        ride6 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80241, USA', user_id: user6)
        ride7 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80241, USA', user_id: user6)
        get "/api/v1/users/#{user}/rides?origin=#{ride6.origin}&destination=#{ride6.destination}"
        rides = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(response).to be_successful
        expect(rides.count).to eq(1)
        rides.each do |ride|
          matched = ride[:attributes][:matched_rides][:data]
          expect(matched.count).to eq(2)
        end
      end
    end
  end

  describe 'sad paths' do
    it 'fails when not given an origin' do
      VCR.use_cassette('incorrect-id') do
        user2 = create(:user).id
        user3 = create(:user).id
        user4 = create(:user).id
        user5 = create(:user).id
        user6 = create(:user).id
        ride2 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80032, USA', user_id: user2)
        ride3 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user3)
        ride4 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80247, USA', user_id: user4)
        ride5 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80000, USA', user_id: user5)
        ride6 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80241, USA', user_id: user6)
        get "/api/v1/users/#{user2}/rides?origin=&destination=#{ride6.destination}"
        sad = JSON.parse(response.body, symbolize_names: true)
        expect(sad[:data]).to eq("You need to send in both complete addresses")
      end
    end

    it 'fails when not given a destination' do
      VCR.use_cassette('empty_destination') do
        user2 = create(:user).id
        user3 = create(:user).id
        user4 = create(:user).id
        user5 = create(:user).id
        user6 = create(:user).id
        ride2 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80032, USA', user_id: user2)
        ride3 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user3)
        ride4 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80247, USA', user_id: user4)
        ride5 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80000, USA', user_id: user5)
        ride6 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80241, USA', user_id: user6)
        get "/api/v1/users/#{user2}/rides?origin=#{ride2.origin}&destination="
        sad = JSON.parse(response.body, symbolize_names: true)
        expect(sad[:data]).to eq("You need to send in both complete addresses")
      end
    end

    it 'fails when either param is nil' do
      VCR.use_cassette('nil_params') do
        user = create(:user).id
        user2 = create(:user).id
        user3 = create(:user).id
        user4 = create(:user).id
        user5 = create(:user).id
        user6 = create(:user).id
        ride = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user)
        ride2 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80032, USA', user_id: user2)
        ride3 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user3)
        ride4 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80247, USA', user_id: user4)
        ride5 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80000, USA', user_id: user5)
        ride6 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80241, USA', user_id: user6)
        get "/api/v1/users/#{user}/rides?origin=#{ride6.origin}"
        sad = JSON.parse(response.body, symbolize_names: true)
        expect(sad[:data]).to eq("You need to send in both complete addresses")
        get "/api/v1/users/#{user}/rides?destination=#{ride.destination}"
        sad = JSON.parse(response.body, symbolize_names: true)
        expect(sad[:data]).to eq("You need to send in both complete addresses")
      end
    end

    it 'fails when either param is nil' do
      VCR.use_cassette('incorrect_user') do
        user = create(:user).id
        user2 = create(:user).id
        user3 = create(:user).id
        user4 = create(:user).id
        user5 = create(:user).id
        user6 = create(:user).id
        ride = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user)
        ride2 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80032, USA', user_id: user2)
        ride3 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user3)
        ride4 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80247, USA', user_id: user4)
        ride5 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80000, USA', user_id: user5)
        ride6 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80241, USA', user_id: user6)
        get "/api/v1/users/10000000/rides?origin=#{ride6.origin}&destination=#{ride6.destination}"
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
        ride = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user)
        ride2 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80032, USA', user_id: user2)
        ride3 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr Denver, CO 80231, USA', user_id: user3)
        ride4 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80247, USA', user_id: user4)
        ride5 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80000, USA', user_id: user5)
        ride6 = create(:ride, origin: '1125 S Kalispell St Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr Denver, CO 80241, USA', user_id: user6)
        ride7 =  create(:ride, origin: "1216 Royal Dublin Lane Dyer, In 46311, USA", destination: "1216 Royal Dublin Lane Dyer, In 46311, USA", user_id: user2)
        get "/api/v1/users/#{user}/rides?origin=#{ride7.origin}&destination=#{ride7.destination}"
        rides = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(rides).to eq('You are our first route with that destination and origin. We will find a hitch soon for you!')
      end
    end
  end
end
