class Api::V1::UsersController < ApplicationController
  before_action :validate_id, only: [:show]

  def create 
    @user = User.create!(user_params)
    @vehicle = Vehicle.create!(user_id: @user.id, make: params[:make], model: params[:model], year: params[:year] )
    if @user.save && @vehicle.save
      render json: {data: "User created successfully"}, status: 201
    else
      invalid_params
    end
  end

  def show
    user = User.find(params[:id])
    render json: ProfileSerializer.new(user)
  end
  
  private 

  def user_params
    params.permit(:email, :password, :bio, :fullname)
  end
end


