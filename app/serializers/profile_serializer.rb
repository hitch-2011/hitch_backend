class ProfileSerializer
  include FastJsonapi::ObjectSerializer
  attributes :fullname,
              :email,
             :bio

  attribute :rides do |object|
    rides = object.pluck_friend_id
    RideSerializer.new(rides)
  end

  attribute :friends do |object|
    friends = self.grab_id(object)
    UserSerializer.new(friends)
  end

  def self.grab_id(object)
    array = []
    object.friends.each do |friend|
      array << User.find(friend.friend_id)
    end
    array
  end
end
