class Api::V1::RidesController < ApplicationController
  def index
    rides = RidesFacade.all_matched_rides(get_zip(params[:origin]), get_zip(params[:destination]))
    render json: RideSerializer.new(rides)
  end

  private

  def rides_params
    params.permit(:origin, :user_id, :destination, :departure_time)
  end
end

