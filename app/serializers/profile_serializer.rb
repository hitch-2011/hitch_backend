class ProfileSerializer
  include FastJsonapi::ObjectSerializer
  attributes :fullname,
             :email,
             :bio,
             :user_rides,
             :matched_rides,
             :friends,
             :vehicle,
             :ride_days 
end
