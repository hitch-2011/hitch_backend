class Api::V1::Users::VehiclesController < ApplicationController

  def create 
    @user = User.find(params[:id])
    @vehicle = @user.vehicles.create!(vehicle_params)
    if @vehicle.save 
      created_vehicle = VehicleSerializer.new(@vehicle)
      render json: created_vehicle
    else
      invalid_params
    end
  end


  private 
  
  def vehicle_params
    params.permit(:make, :model, :year)
  end

end