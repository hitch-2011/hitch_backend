# frozen_string_literal: true

require 'rails_helper'

describe 'Rides Index Endpoint' do
  describe 'GET /rides' do
    it 'can fetch all rides' do
      user = create(:user).id
      ride = create(:ride, user_id: user)

      get '/api/v1/rides'

      expect(response).to be_successful

      rides = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(rides.count).to eq(1)

      rides.each do |ride|
        check_hash_structure(ride, :type, String)

        ride_details = ride[:attributes]

        check_hash_structure(ride_details, :origin, String)
        check_hash_structure(ride_details, :destination, String)
        check_hash_structure(ride_details, :departure_time, String)
        check_hash_structure(ride_details, :user_id, Integer)
      end
    end
  end
end
