class RidesFacade
  class << self

    def all_matched_rides(user, ride)
    origin_data = RidesService.match_origin(ride.zipcode_origin)
    destination_data = RidesService.match_destination(ride.zipcode_destination)
    MatchedRides.new(origin_data, destination_data, ride)
    # grab_origin_zipcodes(origin_data, destination_data, ride)
    end


    # def grab_origin_zipcodes(origin_data, destination_data, ride)
    #   origin_zips = grab_destination_zipcodes(origin_data)
    #   destination_zips = grab_destination_zipcodes(destination_data)
    #   origin_data[:radius][:results].map do |ride|
    #
    #     OpenStruct.new({origin_addr: ride.origin,
    #                original_user_id: ride.user_id,
    #                destination_addr: ride.destination,
    #                 matching_routes: Ride.find_matched_routes(origin_zips, destination_zips),
    #            distance_from_origin: grab_distances(origin_data),
    #       distance_from_destination: grab_distances(destination_data)
    #     })
    #   end
    # end

    def grab_destination_zipcodes(matched_destinations)
      destinations = []
      matched_destinations[:radius][:results].each do |ride|
        destinations << ride[:code]
      end
      destinations
    end

    def grab_distances(destination_data)
      distance_from_array = []
      destination_data[:radius][:results].each do |data|
        distance_from_array << data[:code]
        distance_from_array << data[:distance]
      end
      distance_from_array
    end
  end
end
