class MatchedSerializer
  include FastJsonapi::ObjectSerializer
  set_id :null
  attributes  :origin_addr,
              :destination_addr,
              :original_user_id,
              :distance_from_origin,
              :distance_from_destination
  attribute   :matched_rides  do |object|
    RideSerializer.new(object.matching_routes)
  end
end
