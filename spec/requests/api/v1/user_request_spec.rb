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
  end
end