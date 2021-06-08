class ProfileSerializer
  include FastJsonapi::ObjectSerializer
  attributes :fullname,
             :email,
             :bio,
             :user_rides,
             :friendship_status,
             :vehicle,
             :ride_days 
end
