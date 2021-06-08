require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe 'validations' do
    it { should belong_to :receiver }
    it { should belong_to :requestor }
  end
  describe "validations" do
    it { should validate_presence_of :receiver_id }
    it { should validate_presence_of :requestor_id }
  end

  it 'status starts at pending and be changed to approved' do
    user1 = User.create!(fullname: "full_name", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
    user2 = User.create!(fullname: "full_name", email: "jake@gmail.com", password: "password", bio: "I like driving.")
    friend = Friend.create!(receiver_id: user1.id, requestor_id: user2.id)
    expect(friend.status).to eq("pending")
    expect(friend.pending?).to eq(true)
    expect(friend.approved?).to eq(false)
    expect(user1.friendships.first).to eq(friend)
    expect(user2.friendships.first).to eq(friend)
    user1.friendships.first.update!(status: 1)
    friend = Friend.find(friend.id)
    expect(friend.status).to eq("approved")
    expect(friend.pending?).to eq(false)
  end

  it 'can be deleted when denied endpoint gets hit eventually' do
    user1 = User.create!(fullname: "full_name", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
    user2 = User.create!(fullname: "full_name", email: "jake@gmail.com", password: "password", bio: "I like driving.")
    friend = Friend.create!(receiver_id: user1.id, requestor_id: user2.id)
    expect(friend.pending?).to eq(true)
    user1.friendships.first.delete 
    expect(Friend.all.count).to eq(0)
  end
end
