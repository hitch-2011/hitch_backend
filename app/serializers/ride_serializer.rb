class RideSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin,
             :destination,
             :departure_time,
             :user_id
end

