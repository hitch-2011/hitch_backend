class ReceivedRequests 
  attr_reader :id,
              :fullname,
              :friendship_status,
              :ridedays,
              :ridetime

  def initialize(user)
    @id = user.id 
    @fullname = user.fullname
    @friendship_status = "approve/deny"
    @ridedays = get_ride_days(user)
    @ridetime = user.rides.first.departure_time
  end

  def get_ride_days(user)
    user.rides.first.ridedays.map do |day|
      day.day_of_week
    end
  end
end