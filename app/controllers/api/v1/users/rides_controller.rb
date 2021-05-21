class Api::V1::Users::RidesController < ApplicationController
  before_action :validate_id, only: [:index]
  before_action :find_user, only: [:index]

  def index
    if check_origin_destination(params)
      render json: { data: 'You need to send in both complete addresses' }, status: 400
    else
      matched_rides = RidesFacade.all_matched_rides(get_zip(params[:origin]), get_zip(params[:destination]), params)
      if matched_rides[0].matching_routes.count == 1
        render json: { data: 'You are our first route with that destination and origin. We will find a hitch soon for you!' }, status: 200
      else
        render json: MatchedSerializer.new(matched_rides)
      end
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

  def check_origin_destination(params)
    params[:origin].nil? || params[:destination].nil? || params[:destination].empty? || params[:origin].empty?
  end

  def find_user
    User.find(params[:id])
  end
end
