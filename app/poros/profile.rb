class Profile
  attr_reader :id,
              :fullname,
              :email,
              :bio,
              :user_rides,
              :matched_rides,
              :friends,
              :vehicle,
              :ride_days
  def initialize(user)
    @id = user.id
    @fullname = user.fullname
    @bio = user.bio
    @email = user.email
    @user_rides = user.rides
    @matched_rides = friends_rides(user)
    @friends = grab_friends(user)
    @vehicle = user.vehicle
    @ride_days = grab_string_days(user)
  end

  def friends_rides(user)
    user.friends.map do |friend|
      User.find(friend.friend_id).rides
    end
  end

  def grab_friends(user)
    user.friends.map do |friend|
      User.find(friend.friend_id)
    end
  end

  def grab_string_days(user)
    user.rides.first.ridedays.map do |day|
      day.day_of_week
    end
  end
end
