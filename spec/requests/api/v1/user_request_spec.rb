require 'rails_helper'

describe 'user requests' do
  describe 'POST /api/v1/users' do
    before :each do
      @headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
      @json_payload = {
        email: "test@example.com",
        password: "password",
        password_confirmation: "password"
      }
    end

    it 'can create a new user' do
      post '/api/v1/users', params: @json_payload, as: :json, headers: @headers

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(response.status).to eq 201

      expect(attributes[:email]).to eq 'test@example.com'
      expect(attributes[:api_key]).to_not be_nil
      expect(attributes[:api_key]).to be_a String
    end

    it 'returns an error if no information is sent' do
      post '/api/v1/users', params: {}, as: :json, headers: @headers

      expect(response.status).to eq 422
      expect(response.body).to match(/Email can't be blank, Password can't be blank/)
    end

    it 'returns an error with partial information' do
      post '/api/v1/users', params: {email: 'test@example.com'}, as: :json, headers: @headers

      expect(response.status).to eq 422
      expect(response.body).to match(/Password can't be blank/)
    end

    it 'returns an error if password and confirmation do not match' do
      @json_payload[:password] = 'not_password'
      post '/api/v1/users', params: @json_payload, as: :json, headers: @headers

      expect(response.status).to eq 422
      expect(response.body).to match(/Password and confirmation do not match/)
    end

    it 'returns an error if email is reused' do
      post '/api/v1/users', params: @json_payload, as: :json, headers: @headers
      post '/api/v1/users', params: @json_payload, as: :json, headers: @headers

      expect(response.status).to eq 422
      expect(response.body).to match(/Validation failed: Email has already been taken/)
    end
  end
end