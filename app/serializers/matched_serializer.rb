class MatchedSerializer
  include FastJsonapi::ObjectSerializer
  set_id :null
  attributes  :origin_zipcode,
              :destination_zipcode,
              :distance 
  attribute   :matched_rides  do |object|
    RideSerializer.new(object.matching_routes)
  end
end
