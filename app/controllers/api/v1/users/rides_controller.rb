class Api::V1::Users::RidesController < ApplicationController
  def create
    user = User.find(rides_params[:user_id])
    result = MapquestService.find_drivable_route(params[:origin], params[:destination])
    if result[:route].nil?
      render json: { data: 'No driving directions found' }, status: 400
    else
      ride = user.rides.create!(rides_params)
      render json: { data: 'Ride created successfully' }, status: :created
    end
  end

  private

  def rides_params
    params.permit(:origin, :user_id, :destination, :departure_time)
  end
end