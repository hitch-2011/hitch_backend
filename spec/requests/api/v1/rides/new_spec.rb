# frozen_string_literal: true

require 'rails_helper'

xdescribe 'New Rides' do
  xit 'can create a ride ' do
    user        = create(:user)
    ride_params = {
                    origin: '1125 S Kalispell St Aurora, CO 80017',
                    destination: '15668 E Girard Pl Aurora, CO 80013',
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
