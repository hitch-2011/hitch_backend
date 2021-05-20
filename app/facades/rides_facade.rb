class RidesFacade
  class << self
    def all_matched_rides(origin_zip, destination_zip)
    origin_data = RidesService.match_origin(origin_zip)
    destination_data = RidesService.match_destination(destination_zip)
    grab_origin_zipcodes(origin_data, destination_data)
    end

    def grab_origin_zipcodes(origin_data, destination_data)
      origin_zips = grab_destination_zipcodes(origin_data)
      destination_zips = grab_destination_zipcodes(destination_data)
      origin_data[:radius][:results].map do |ride|
        OpenStruct.new({origin_zipcode: origin_data[:radius][:query][:code],
                   destination_zipcode: destination_data[:radius][:query][:code],
                       matching_routes: Ride.find_matched_routes(origin_zips, destination_zips),
                              distance: "These routes are in a 2 mile radius of your origin and destination"
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
  end
end
