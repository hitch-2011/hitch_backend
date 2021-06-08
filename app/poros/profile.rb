class Profile
  attr_reader :id,
              :fullname,
              :email,
              :bio,
              :user_rides,
              :friendship_status,
              :vehicle,
              :ride_days
  def initialize(user, profile_id)
    @id = user.id
    @fullname = user.fullname
    @bio = user.bio
    @email = user.email
    @user_rides = user.rides
    @friendship_status = find_status(user, profile_id)
    @vehicle = user.vehicles
    @ride_days = grab_string_days(user)
  end

  def find_status(user, profile_id)
    friends_array = user.friendships
    friend = friends_array.find{|friend| friend.receiver_id == profile_id || friend.requestor_id == profile_id}
    if user.id == profile_id
      "self"
      # if a record in friends_array has profile_id as receiver or requestor and status is pending, return if user is reciever or requestor
    elsif !friend.nil? && friend.status == "pending"
      if friend.receiver_id == user.id 
        "approve/deny"
      else 
        "pending"
      end
# if a record in friends_array has profile_id as receiver or requestor and status is approved, return approved AND profile.id's email
    elsif !friend.nil? && friend.status == "approved"
      "approved"
# if no record in friends_array has profile_id as reciever or requestor, return "add"
    else
      "add"
    end
  end
  # def friends_rides(user)
  #   user.friends.map do |friend|
  #     User.find(friend.friend_id).rides
  #   end
  # end

  # def grab_friends(user)
  #   user.friends.map do |friend|
  #     User.find(friend.friend_id)
  #   end
  # end

  def grab_string_days(user)
    user.rides.first.ridedays.map do |day|
      day.day_of_week
    end
  end
end
