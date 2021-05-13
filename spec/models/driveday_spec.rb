require 'rails_helper'

RSpec.describe Driveday, type: :model do
  describe 'relationships' do
    it {should belong_to :drive}
  end

  describe 'validations' do
    it {should validate_presence_of :day_of_week}
  end
end
