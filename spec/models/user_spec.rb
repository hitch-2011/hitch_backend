require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :about_me}
  end

  describe 'relationships' do
    it {should have_many :drives}
    it {should have_many :drive_days}
  end
end
