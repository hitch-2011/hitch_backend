require 'rails_helper'

RSpec.describe 'Api::V1::Users Create', type: :request do
  describe 'happy path' do
    it 'should return a 201 when a user is created with valid params' do
      valid_params = {
                      email: 'example@email.com',
                      password: '123',
                      bio: 'Hi my name is example, I drive a whole bunch and want to carpool',
                      fullname: 'Naomi Nagata',
                      make: 'Hyundai',
                      model: 'Sonata',
                      year: '2013'
                     } 

      post api_v1_users_path, params: valid_params
      expect(response).to have_http_status(200)
      data = JSON.parse(response.body, symbolize_names: true)
      check_hash_structure(data[:data], :id, String)
      check_hash_structure(data[:data], :attributes, Hash)
    end

    it 'should return a 201 if no bio is given but other params are' do
      valid_params = {
                      email: 'example@email.com',
                      password: '123',
                      fullname: 'Naomi Nagata',
                      make: 'Hyundai',
                      model: 'Sonata',
                      year: '2013'
                     }

      post api_v1_users_path, params: valid_params
      expect(response).to have_http_status(200)
      data = JSON.parse(response.body, symbolize_names: true)
      check_hash_structure(data[:data], :id, String)
      check_hash_structure(data[:data], :attributes, Hash)

    end
  end

  describe 'sad path' do
    it 'returns an error message if no email is present' do
      invalid_params = {
                        password: '123',
                        bio: 'Hi my name is example, I drive a whole bunch and want to carpool',
                        fullname: 'Naomi Nagata',
                        make: 'Hyundai',
                        model: 'Sonata',
                        year: '2013'
                      }

       post api_v1_users_path, params: invalid_params
       json = JSON.parse(response.body, symbolize_names: true)
       check_hash_structure(json, :error, String)
       expect(json[:error]).to eq("Validation failed: Email can't be blank, Email is invalid")
    end

    it 'returns an error message if no password is given' do
      invalid_params = {
                        email: 'example@email.com',
                        password: '',
                        bio: 'Hi my name is example, I drive a whole bunch and want to carpool',
                        fullname: 'Naomi Nagata',
                        make: 'Hyundai',
                        model: 'Sonata',
                        year: '2013'
                      }

       post api_v1_users_path, params: invalid_params
       json = JSON.parse(response.body, symbolize_names: true)
       check_hash_structure(json, :error, String)
       expect(json[:error]).to eq("Validation failed: Password can't be blank")
    end
  end
end
