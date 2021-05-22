class RideDistance
  attr_reader :id,
              :departure_time,
              :zipcode_origin,
              :zipcode_destination,
              :user_id,
              :origin,
              :destination,
              :distance_from_origin,
              :distance_from_destination,
              :ridedays

  def initialize(ride, distances, distances2)
    @id = ride.id
    @departure_time = ride.departure_time
    @zipcode_origin = ride.zipcode_origin
    @zipcode_destination = ride.zipcode_destination
    @user_id = ride.user_id
    @user_name = User.find(@user_id).fullname
    @origin = ride.origin
    @destination = ride.destination
    @distance_from_origin = match_distances(ride, distances, zipcode_origin)
    @distance_from_destination = match_distances(ride, distances2, zipcode_destination)
    @ridedays = grab_string_days(User.find(@user_id))
  end

  def match_distances(ride, distances, variable)
    distances.each_with_index do |i, index|
      return distances[index + 1] if i == variable
    end
  end

  def grab_string_days(user)
    user.rides.first.ridedays.map do |day|
      day.day_of_week
    end
  end
end
