# frozen_string_literal: true
require 'rails_helper'

describe 'New Rides' do
  describe 'happy path' do 
    it 'can create a ride without n/s/e/w' do
      VCR.use_cassette('create_new_ride_happy_path') do 
        user        = create(:user)
        ride_params = {
          origin: '3956 Alcott St Denver, CO 80211',
          destination: '1138 Corona St Denver, CO 80218',
          departure_time: '15:30',
          user_id: user.id,
        }
        
        headers     = { 'CONTENT_TYPE' => 'application/json' }
        
        post "/api/v1/users/#{user.id}/rides", headers: headers, params: JSON.generate(ride_params)
        
        created_ride = Ride.last
        
        expect(response).to be_successful
        expect(response).to have_http_status(:created)
        expect(created_ride.origin).to eq(ride_params[:origin])
        expect(created_ride.destination).to eq(ride_params[:destination])
        expect(created_ride.departure_time).to eq(ride_params[:departure_time])
        expect(created_ride.user_id).to eq(ride_params[:user_id])
      end
    end

    it 'can create a ride WITH n/s/e/w' do
      VCR.use_cassette('add_in_direction_create_new_ride_happy_path') do 
        user        = create(:user)
        ride_params = {
          origin: '1125 South Kalispell St, Aurora, CO 80017',
          destination: '1138 N Corona St Denver, CO 80218',
          departure_time: '15:30',
          user_id: user.id,
        }
        
        headers     = { 'CONTENT_TYPE' => 'application/json' }
        
        post "/api/v1/users/#{user.id}/rides", headers: headers, params: JSON.generate(ride_params)
        
        created_ride = Ride.last
        
        expect(response).to be_successful
        expect(response).to have_http_status(:created)
        expect(created_ride.origin).to eq(ride_params[:origin])
        expect(created_ride.destination).to eq(ride_params[:destination])
        expect(created_ride.departure_time).to eq(ride_params[:departure_time])
        expect(created_ride.user_id).to eq(ride_params[:user_id])
      end
    end

    it 'can create a long distance ride' do
      VCR.use_cassette('long_distance_create_new_ride_happy_path') do 
        user        = create(:user)
        ride_params = {
          origin: '300 LaPorte Ave, Fort Collins, CO 80521',
          destination: '7120 N Academy Blvd, Colorado Springs, CO, 80920',
          departure_time: '15:30',
          user_id: user.id,
        }
        
        headers     = { 'CONTENT_TYPE' => 'application/json' }
        
        post "/api/v1/users/#{user.id}/rides", headers: headers, params: JSON.generate(ride_params)
        
        created_ride = Ride.last
        
        expect(response).to be_successful
        expect(response).to have_http_status(:created)
        expect(created_ride.origin).to eq(ride_params[:origin])
        expect(created_ride.destination).to eq(ride_params[:destination])
        expect(created_ride.departure_time).to eq(ride_params[:departure_time])
        expect(created_ride.user_id).to eq(ride_params[:user_id])
      end
    end
  end

  describe 'sad path' do 
    it 'cannot find a route if an ocean is in the way' do 
      VCR.use_cassette('cannot_find_route') do 
        user        = create(:user)
        ride_params = {
          origin: '1125 S Kalispell St Aurora, CO 80017',
          destination: 'tokyo, japan',
          departure_time: '15:30',
          user_id: user.id,
        }
        
        headers     = { 'CONTENT_TYPE' => 'application/json' }
        
        post "/api/v1/users/#{user.id}/rides", headers: headers, params: JSON.generate(ride_params)
        
        expect(response.status).to eq(400)
        
        json_response = JSON.parse(response.body, symbolize_names: true)[:data]
        
        expect(json_response).to eq("No driving directions found")
      end
    end

    it 'cannot find a route if an ocean is in the way' do 
      VCR.use_cassette('cannot_find_route_international') do 
        user        = create(:user)
        ride_params = {
          origin: '1125 S Kalispell St Aurora, CO 80017',
          destination: 'Berlin, Germany',
          departure_time: '15:30',
          user_id: user.id,
        }
        
        headers     = { 'CONTENT_TYPE' => 'application/json' }
        
        post "/api/v1/users/#{user.id}/rides", headers: headers, params: JSON.generate(ride_params)
        
        expect(response.status).to eq(400)
        
        json_response = JSON.parse(response.body, symbolize_names: true)[:data]
        
        expect(json_response).to eq("No driving directions found")
      end
    end
  end
end
