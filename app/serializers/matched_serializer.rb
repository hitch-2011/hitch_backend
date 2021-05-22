class MatchedSerializer
  include FastJsonapi::ObjectSerializer
  set_id :user_id
  attributes  :matched_routes
  

end
