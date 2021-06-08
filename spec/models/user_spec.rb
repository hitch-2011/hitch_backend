require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :fullname}

  end

  describe 'relationships' do
    it {should have_many :rides}
  end

  describe 'instance methods' do
    it 'grabs all rides associated with user' do
      user1 = User.create!(fullname: "full_name", email: "DOMinic@gmail.com", password: "password", bio: "I like driving.")
      user2 = User.create!(fullname: "full_name", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "full_name", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      user4= User.create!(fullname: "full_name", email: "differnt@gmail.com", password: "password", bio: "I like driving.")
      user5 = User.create!(fullname: "full_name", email: "new@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(requestor_id: user1.id, receiver_id: user2.id, status: 1)
      friend = Friend.create!(requestor_id: user1.id, receiver_id: user3.id, status: 1)
      friend = Friend.create!(requestor_id: user1.id, receiver_id: user5.id, status: 1)
      trip = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      trip2 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user3.id )
      trip3 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user2.id )
      trip4 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user4.id )
      trip5 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user5.id )
      expect(user1.email).to eq("dominic@gmail.com")
      expect(user1.friendships.count).to eq(3)
    end
  end
end
