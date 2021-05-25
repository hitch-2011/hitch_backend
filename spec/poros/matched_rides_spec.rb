require 'rails_helper'


describe 'Matched Rides Poro' do
  describe 'we can pass information to create matched routes objects' do
    it 'shows profile information' do
      origin_data = {:radius=>{:query=>{:code=>"80017", :unit=>"miles", :radius=>"4", :country=>"us"}, :results=>[{:code=>"80017", :city=>"Aurora", :state=>"CO", :city_en=>nil, :state_en=>nil, :distance=>0}]}}
      destination_data = {:radius=>
  {:query=>{:code=>"80231", :unit=>"miles", :radius=>"4", :country=>"us"},
   :results=>
    [{:code=>"80231", :city=>"Denver", :state=>"CO", :city_en=>nil, :state_en=>nil, :distance=>0},
     {:code=>"80247", :city=>"Denver", :state=>"CO", :city_en=>nil, :state_en=>nil, :distance=>1.24},
     {:code=>"80224", :city=>"Denver", :state=>"CO", :city_en=>nil, :state_en=>nil, :distance=>1.53},
     {:code=>"80222", :city=>"Denver", :state=>"CO", :city_en=>nil, :state_en=>nil, :distance=>2.39}]}}
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
     matched = MatchedRides.new(origin_data, destination_data, ride)
     expect(matched.user_id).to eq(user)
     expect(matched.matched_routes.count).to eq(3)
    end
  end
end
