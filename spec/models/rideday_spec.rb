require 'rails_helper'

RSpec.describe Rideday, type: :model do
  describe 'relationships' do
    it {should belong_to :ride}
  end

  describe 'validations' do
    it {should validate_presence_of :day_of_week}
  end
end
