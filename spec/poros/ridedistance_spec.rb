require 'rails_helper'


describe 'Matched Rides Poro' do
  describe 'we can pass information to create matched routes objects' do
    it 'shows ride distance information' do
      distances = ["80017", 0]
      distances2 = ["80231", 0, "80247", 1.24, "80224", 1.53, "80222", 2.39]
      user = create(:user).id
      ride = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
      ride2 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80032, USA', user_id: user)
      ride3 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
      ride4 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80247, USA', user_id: user)
      ride5 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80000, USA', user_id: user)
      ride6 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride.id)
      rideday2 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
      rideday3 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride.id)
      rideday4 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
      rideday5 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride.id)
      rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
      rideday7 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
      rideday8 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
      rideday9 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
      rideday10 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride4.id)
      distances = RideDistance.new(ride, distances, distances2)
      expect(distances).to respond_to(:id)
      expect(distances).to respond_to(:departure_time)
      expect(distances).to respond_to(:zipcode_origin)
      expect(distances).to respond_to(:zipcode_destination)
      expect(distances).to respond_to(:user_id)
      expect(distances).to respond_to(:origin)
      expect(distances).to respond_to(:destination)
      expect(distances).to respond_to(:distance_from_origin)
      expect(distances).to respond_to(:distance_from_destination)
      expect(distances).to respond_to(:ridedays)
    end
  end
end
