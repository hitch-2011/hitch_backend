class ProfileSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email,
             :about_me

  attribute :rides do |object|
    RideSerializer.new(object.rides)
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
