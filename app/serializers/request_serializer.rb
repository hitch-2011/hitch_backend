class RequestSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :fullname, :friendship_status, :ridedays, :ridetime
end
