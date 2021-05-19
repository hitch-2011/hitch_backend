class RidesFacade
  class << self
    def all_matched_rides(origin_zip, destination_zip)
      RidesService.match_rides(origin_zip, destination_zip)
    end
  end
end