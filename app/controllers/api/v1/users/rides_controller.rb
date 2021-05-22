class Api::V1::Users::RidesController < ApplicationController
  before_action :validate_id, only: [:index]
  before_action :find_user_and_ride, only: [:index]

  def index
    matched_rides = RidesFacade.all_matched_rides(@user, @ride)
    if matched_rides.matched_routes.count == 1
      render json: { data: 'You are our first route in those areas! We will find a hitch for you soon!' }, status: 200
    else
      render json: MatchedSerializer.new(matched_rides)
    end
  end

  def create
    user = User.find(rides_params[:user_id])
    result = MapquestService.find_drivable_route(params[:origin], params[:destination])
    if result[:route].nil?
      render json: { data: 'No driving directions found' }, status: 400
    else
      @ride = user.rides.create!(rides_params)
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

  def find_user_and_ride
    @user = User.find(params[:id])
    @ride = @user.rides.first
  end
end
