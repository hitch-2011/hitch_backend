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
      user1 = User.create!(fullname: "full_name", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      user2 = User.create!(fullname: "full_name", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "full_name", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      user4= User.create!(fullname: "full_name", email: "differnt@gmail.com", password: "password", bio: "I like driving.")
      user5 = User.create!(fullname: "full_name", email: "new@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user5.id)
      trip = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      trip2 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user3.id )
      trip3 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user2.id )
      trip4 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user4.id )
      trip5 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user5.id )
      expect(user1.pluck_friend_id.count).to eq(4)
      expect(user1.pluck_friend_id).to eq([trip, trip2, trip3, trip5])
    end

    it 'can return users in an array' do
      user1 = User.create!(fullname: "full_name", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      user2 = User.create!(fullname: "full_name", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      user3 = User.create!(fullname: "full_name", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
      user5 = User.create!(fullname: "full_name", email: "new@gmail.com", password: "password", bio: "I like driving.")
      friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
      friend = Friend.create!(user_id: user1.id, friend_id: user3.id)
      trip = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user1.id )
      trip2 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user3.id )
      trip3 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user2.id )
      trip5 = Ride.create!(origin: "3300 S Tamarac Dr, Denver, CO 80231, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: user5.id )
      expect(user1.pluck(user1)).to eq([user1.id, user2.id, user3.id])
    end
  end
end
