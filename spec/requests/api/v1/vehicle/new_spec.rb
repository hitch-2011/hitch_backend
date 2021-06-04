require 'rails_helper'

RSpec.describe 'Api::V1::Vehicles Create', type: :request do 
  describe 'happy path' do 
    it 'should return a 200 when a vehicle is created with valid params' do 
      user_params = {
        email: 'example@email.com',
        password: '123',
        bio: 'Hi my name is example, I drive a whole bunch and want to carpool',
        fullname: 'Naomi Nagata'
       } 
      @user = User.create(user_params)
      
      valid_params = { make: 'Subaru',
                       model: 'Outback',
                       year: '2005'}

      post "/api/v1/users/#{@user.id}/vehicles", params: valid_params
      expect(response).to have_http_status(200)
      data = JSON.parse(response.body, symbolize_names: true)
      check_hash_structure(data[:data], :id, String)
      check_hash_structure(data[:data], :attributes, Hash)
      check_hash_structure(data[:data][:attributes], :make, String)
    end
  end
  describe 'sad path' do 
    it 'should return an error if no year is in valid params' do 
      user_params = {
        email: 'example@email.com',
        password: '123',
        bio: 'Hi my name is example, I drive a whole bunch and want to carpool',
        fullname: 'Naomi Nagata'
       } 
      @user = User.create(user_params)
      
      valid_params = { make: 'Subaru',
                       model: 'Outback'}

      post "/api/v1/users/#{@user.id}/vehicles", params: valid_params
      json = JSON.parse(response.body, symbolize_names: true)
       check_hash_structure(json, :error, String)
       expect(json[:error]).to eq("Validation failed: Year can't be blank")
    end
    it 'should return an error if no model is in valid params' do 
      user_params = {
        email: 'example@email.com',
        password: '123',
        bio: 'Hi my name is example, I drive a whole bunch and want to carpool',
        fullname: 'Naomi Nagata'
       } 
      @user = User.create(user_params)
      
      valid_params = { make: 'Subaru',
                       year: '2009'}

      post "/api/v1/users/#{@user.id}/vehicles", params: valid_params
      json = JSON.parse(response.body, symbolize_names: true)
       check_hash_structure(json, :error, String)
       expect(json[:error]).to eq("Validation failed: Model can't be blank")
    end
    it 'should return an error if no make is in valid params' do 
      user_params = {
        email: 'example@email.com',
        password: '123',
        bio: 'Hi my name is example, I drive a whole bunch and want to carpool',
        fullname: 'Naomi Nagata'
       } 
      @user = User.create(user_params)
      
      valid_params = { model: 'Outback',
                       year: '2009'}

      post "/api/v1/users/#{@user.id}/vehicles", params: valid_params
      json = JSON.parse(response.body, symbolize_names: true)
       check_hash_structure(json, :error, String)
       expect(json[:error]).to eq("Validation failed: Make can't be blank")
    end
  end
end