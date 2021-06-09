class Api::V1::Users::FriendsController < ApplicationController

  def create
    logged_in = params[:id].to_i
    user = User.find(params[:reciever_id])
    new_friend = Friend.create!(receiver_id: params[:reciever_id], requestor_id: params[:id])
    profile = Profile.new(user, logged_in)
    render json: ProfileSerializer.new(profile)
  end
end
