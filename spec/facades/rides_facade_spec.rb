# 
# require 'rails_helper'
#
#
# describe 'Rides Facade' do
#   describe 'passed bad params' do
#     it 'does something if params there are no rides' do
#       VCR.use_cassette('facade_test') do
#         user = create(:user).id
#         no_match_orgin = '46311'
#         no_match_destination = '46311'
#         params = {:origin => "1216 Royal Dublin Lane, Dyer, In 46311, USA", :destination =>"1216 Royal Dublin Lane, Dyer, In 46311, USA", "controller"=>"api/v1/users/rides", "action"=>"index", :id =>"#{user}"}
#         ride = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
#         ride2 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80032, USA', user_id: user)
#         ride3 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80022, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
#         ride4 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80247, USA', user_id: user)
#         ride5 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80000, USA', user_id: user)
#         ride6 = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)
#         rides = RidesFacade.all_matched_rides(no_match_orgin, no_match_destination, params)
#       end
#     end
#   end
# end
