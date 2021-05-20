require 'rails_helper'

RSpec.describe MapquestService do
  it 'gets a JSON response with drivable route information' do
    VCR.use_cassette('denver') do
      origin = '3956 Alcott St Denver, CO 80211'
      destination = '1138 Corona St Denver, CO 80218'
      data = MapquestService.find_drivable_route(origin, destination)

      expect(data).to be_a(Hash)
      check_hash_structure(data, :route, Hash)
    end
  end

  it 'returns null if no city is found' do
    VCR.use_cassette('rural_area') do
      origin = ''
      destination = '1138 Corona St Denver, CO 80218'
      data = MapquestService.find_drivable_route(origin, destination)

      expect(data).to be_a(Hash)
      check_hash_structure(data[:route], :routeError, Hash)
    end
  end
end