<<<<<<< HEAD
class Api::V1::UsersController < ApplicationController
  before_action :validate_id, only: [:show]
  
  def create 
    @user = User.create(user_params)
    if @user.save
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
    params.permit(:email, :password, :password_confirmation, :bio, :fullname)
  end
end


