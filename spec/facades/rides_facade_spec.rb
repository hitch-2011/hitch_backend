
require 'rails_helper'


describe 'Rides Facade' do
  describe 'passed bad params' do
    it 'does something if params there are no rides' do
      VCR.use_cassette('facade_test') do
        user = create(:user)
        user2 = create(:user)
        user3 = create(:user)
        user4 = create(:user)
        user5 = create(:user)
        user6 = create(:user)
        ride = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user.id)
        ride1 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user2.id)
        ride2 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80032, USA', user_id: user3.id)
        ride3 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user4.id)
        ride4 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80247, USA', user_id: user5.id)
        ride5 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80000, USA', user_id: user6.id)
        ride6 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user6.id)
        rides = RidesFacade.all_matched_rides(user, ride)
        expect(rides.matched_routes.count).to eq(4)
        matched = rides.matched_routes.map do |ride|
          ride.user_id
        end
        expect(matched).to eq([user.id, user2.id, user5.id, user6.id])
      end
    end
  end
end
