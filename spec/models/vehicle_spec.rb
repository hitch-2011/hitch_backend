require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'relationships' do
    it {should belong_to :user}
  end
  describe 'validations' do
    it {should validate_presence_of :make}
    it {should validate_presence_of :model}
    it {should validate_presence_of :year}
  end 
end
