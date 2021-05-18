class Api::V1::Users::RidesController < ApplicationController
  def create
    user = User.find(rides_params[:user_id])
    ride = user.rides.create!(rides_params)
    render json: RideSerializer.new(ride), status: :created
  end

  private

  def rides_params
    params.permit(:origin, :user_id, :destination, :departure_time)
  end
end