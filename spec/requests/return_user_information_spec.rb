require 'rails_helper'

RSpec.describe "Users API Endpoints" do
  describe "User Details" do
    it 'should return user details details based on id' do
    user1 = User.create!(email: "dominic@gmail.com", password: "password", about_me: "I like driving.")
      get "/api/v1/users/#{user1.id}"
      expect(response).to be_successful
      user_details = JSON.parse(response.body, symbolize_names:true)
      require "pry"; binding.pry
    end
  end
end
