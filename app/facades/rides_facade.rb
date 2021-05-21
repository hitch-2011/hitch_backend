class RidesFacade
  class << self

    def all_matched_rides(origin_zip, destination_zip, params)
    origin_data = RidesService.match_origin(origin_zip)
    destination_data = RidesService.match_destination(destination_zip)
    grab_origin_zipcodes(origin_data, destination_data, params)
    end

    def grab_origin_zipcodes(origin_data, destination_data, params)
      origin_zips = grab_destination_zipcodes(origin_data)
      destination_zips = grab_destination_zipcodes(destination_data)
      origin_data[:radius][:results].map do |ride|
        OpenStruct.new({origin_addr: params[:origin],
                   original_user_id: params[:id],
                   destination_addr: params[:destination],
                    matching_routes: Ride.find_matched_routes(origin_zips, destination_zips),
               distance_from_origin: grab_distances(origin_data),
          distance_from_destination: grab_distances(destination_data)
        })
      end
    end

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
