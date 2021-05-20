require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe 'validations' do
    it { should belong_to :user }
    it { should belong_to :friend }
  end
  describe "validations" do
    it { should validate_presence_of :user }
    it { should validate_presence_of :friend }
  end

  it 'show status and be changed ' do
    user1 = User.create!(fullname: "full_name", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
    user2 = User.create!(fullname: "full_name", email: "jake@gmail.com", password: "password", bio: "I like driving.")
    friend = Friend.create!(user_id: user1.id, friend_id: user2.id)
    expect(friend.status).to eq("default")
    expect(friend.default?).to eq(true)
    expect(friend.pending?).to eq(false)
    expect(friend.denied?).to eq(false)
    expect(friend.approved?).to eq(false)
  end

  it 'can be other status' do
    user1 = User.create!(fullname: "full_name", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
    user2 = User.create!(fullname: "full_name", email: "jake@gmail.com", password: "password", bio: "I like driving.")
    friend = Friend.create!(user_id: user1.id, friend_id: user2.id, status: :pending)
    expect(friend.default?).to eq(false)
    expect(friend.pending?).to eq(true)
    expect(friend.denied?).to eq(false)
    expect(friend.approved?).to eq(false)
  end

  it 'can be denied' do
    user1 = User.create!(fullname: "full_name", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
    user2 = User.create!(fullname: "full_name", email: "jake@gmail.com", password: "password", bio: "I like driving.")
    friend = Friend.create!(user_id: user1.id, friend_id: user2.id, status: :denied)
    expect(friend.default?).to eq(false)
    expect(friend.pending?).to eq(false)
    expect(friend.denied?).to eq(true)
    expect(friend.approved?).to eq(false)
  end

  it 'can be approved' do
    user1 = User.create!(fullname: "full_name", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
    user2 = User.create!(fullname: "full_name", email: "jake@gmail.com", password: "password", bio: "I like driving.")
    friend = Friend.create!(user_id: user1.id, friend_id: user2.id, status: :approved)
    expect(friend.default?).to eq(false)
    expect(friend.pending?).to eq(false)
    expect(friend.denied?).to eq(false)
    expect(friend.approved?).to eq(true)
  end
end
