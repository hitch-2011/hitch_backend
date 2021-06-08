class Api::V1::UsersController < ApplicationController
  before_action :validate_id, only: [:show]

  def create
    @user = User.create!(user_params)
    if @user.save 
      created_user = UserSerializer.new(@user)
      render json: created_user
    else
      invalid_params
    end
  end

  def show
    profile_id = params[:profile_id].to_i
    user = User.find(params[:id])
    profile = Profile.new(user, profile_id)
    render json: ProfileSerializer.new(profile)
  end

  private

  def user_params
    params.permit(:email, :password, :bio, :fullname)
  end
end
