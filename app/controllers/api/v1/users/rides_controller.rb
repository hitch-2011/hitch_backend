class Api::V1::Users::RidesController < ApplicationController

  # def create
  #   user = User.find(rides_params[:user_id])
  #   # if AddressValidatorFacade.validate_address(rides_params[:origin], rides_params[:destination]) == true
  #     ride = user.rides.create!(rides_params)
  #     #render json: RideSerializer.new(ride), status: :created
  #   # else
  #   #   'route is invalid'
  #   # end
  # end

  def index
    matched_rides = RidesFacade.all_matched_rides(get_zip(params[:origin]), get_zip(params[:destination]))
    render json: MatchedSerializer.new(matched_rides)
  end 

  def create
    user = User.find(rides_params[:user_id])
    result = MapquestService.find_drivable_route(params[:origin], params[:destination])
    if result[:route].nil?
      render json: { data: 'No driving directions found' }, status: 400
    else
      @ride = user.rides.create!(rides_params)
      @ride[:zipcode_origin] = get_zip(params[:origin])
      @ride[:zipcode_destination] = get_zip(params[:destination])
      
        make_ride_days(@ride, params[:days])
      
      render json: { data: 'Ride created successfully' }, status: :created
    end

  end

  def make_ride_days(ride, days)
    days.each do |day|
      ride.ridedays.create!(day_of_week: day)
    end
  end


  private

  def rides_params
    params.permit(:origin, :user_id, :destination, :departure_time)
  end

  def rideday_params 
    params.permit(:days)
  end

end
