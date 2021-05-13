require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'validations' do
    it {should validate_presence_of :origin}
    it {should validate_presence_of :destination}
    it {should validate_presence_of :departure_time}
  end

  describe 'relationships' do
    it {should belong_to :user}
  end
end
