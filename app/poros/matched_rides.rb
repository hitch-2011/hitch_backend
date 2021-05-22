class MatchedRides

  attr_reader :user_id, :matched_routes
  def initialize(origin_data, destination_data, ride)
    @user_id = ride.user_id
    @matched_routes = match_routes_with_distances(origin_data, destination_data, ride)
  end


  def match_routes_with_distances(origin_data, destination_data, ride)
    origin_zips = grab_destination_zipcodes(origin_data)
    destination_zips = grab_destination_zipcodes(destination_data)
    rides = Ride.find_matched_routes(origin_zips, destination_zips)
    distances = grab_distances(origin_data)
    distances2 = grab_distances(destination_data)
    final_rides = rides.map do |ride|
      RideDistance.new(ride, distances, distances2)
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
