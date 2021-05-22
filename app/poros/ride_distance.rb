class RideDistance
  attr_reader :id,
              :departure_time,
              :zipcode_origin,
              :zipcode_destination,
              :user_id,
              :origin,
              :destination,
              :distance_from_origin,
              :distance_from_destination

  def initialize(ride, distances, distances2)
    @id = ride.id
    @departure_time = ride.departure_time
    @zipcode_origin = ride.zipcode_origin
    @zipcode_destination = ride.zipcode_destination
    @user_id = ride.user_id
    @origin = ride.origin
    @destination = ride.destination
    @distance_from_origin = match_distances(ride, distances, zipcode_origin)
    @distance_from_destination = match_distances(ride, distances2, zipcode_destination)
  end

  def match_distances(ride, distances, variable)
    distances.each_with_index do |i, index|
      return distances[index + 1] if i == variable
    end
  end
end
