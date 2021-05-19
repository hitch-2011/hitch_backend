class Api::V1::Users::RidesController < ApplicationController
  def create
    user = User.find(rides_params[:user_id])
    # if AddressValidatorFacade.validate_address(rides_params[:origin], rides_params[:destination]) == true

    # reach out to micro service to validate drivable route true
    result = MapquestService.find_drivable_route(params[:origin], params[:destination])
    binding.pry
    # if true, create ride
    #  send back 201
    ride = user.rides.create!(rides_params)
    
    # if false, do NOT creat ride
    #  send error message
      render json: RideSerializer.new(ride), status: :created
    # else 
    #   'route is invalid'
    # end
  end

  private

  def rides_params
    params.permit(:origin, :user_id, :destination, :departure_time)
  end
end