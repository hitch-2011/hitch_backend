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

  def update
    friend = Friend.find(params[:friend_id])
    friend.update!(status: 1)
    render json: { message: "Friendship approved" }, status: 200
  end

  def index 
    user = User.find(params[:id])
    received_requests = user.friendships.find_all{|friend| friend.status == 'pending' && friend.receiver_id == user.id}
    received_requests_users = received_requests.map{|friend| User.find(friend.requestor_id)}
    if received_requests.empty?
      render json: { message: ["no received requests"] }
    else
      requested = []
      received_requests_users.each{|user| requested << ReceivedRequests.new(user)}
      render json: RequestSerializer.new(requested)
    end
  end
end
