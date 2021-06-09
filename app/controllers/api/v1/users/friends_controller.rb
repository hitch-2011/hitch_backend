class Api::V1::Users::FriendsController < ApplicationController

  def create
    logged_in = params[:id].to_i
    user = User.find(params[:receiver_id])
    new_friend = Friend.create!(receiver_id: params[:receiver_id], requestor_id: params[:id])
    profile = Profile.new(user, logged_in)
    render json: ProfileSerializer.new(profile)
  end

  def destroy
    Friend.destroy(params[:friend_id])
    render json: { message: "Friendship denied." }, status: 200
  end
end
