class RidesFacade
  class << self

    def all_matched_rides(user, ride)
    origin_data = RidesService.match_origin(ride.zipcode_origin)
    destination_data = RidesService.match_destination(ride.zipcode_destination)
    MatchedRides.new(origin_data, destination_data, ride)
    end
  end
end
