class Api::V1::UsersController < ApplicationController 
  def create 
    @user = User.create(user_params)
    if @user.save
      render json: {data: "User created successfully"}, status: 201
    else
      invalid_params
    end
  end

  private 
  def user_params
    params.permit(:email, :password, :about_me)
  end
end