require 'rails_helper'

describe 'road trip requests', :vcr do
  describe 'POST /api/v1/road_trip' do
    before :each do
      user = create(:user)
      api_key = user.keys.first.value
      @headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
      @json_payload = {
        origin: 'Washington,DC',
        destination: 'Boston,MA',
        api_key: api_key
      }
    end

    it 'gives the weather at the destination' do
      post '/api/v1/road_trip', params: @json_payload, as: :json, headers: @headers

      expect(response.status).to eq 200

      info = JSON.parse(response.body, symbolize_names: true)
      data = info[:data]
      attributes = data[:attributes]

      expect(data[:id]).to be_nil
      expect(data[:type]).to eq 'roadtrip'
      expect(attributes[:start_city]).to eq @json_payload[:origin]
      expect(attributes[:end_city]).to eq @json_payload[:destination]
      expect(attributes[:travel_time]).to be_a String
      expect(attributes[:weather_at_eta]).to be_a Hash
      expect(attributes[:weather_at_eta][:temperature]).to be_a Float
      expect(attributes[:weather_at_eta][:conditions]).to be_a String
    end

    it 'gives an error if the api_key is invalid' do
      @json_payload[:api_key] = 'not a valid key'
      post '/api/v1/road_trip', params: @json_payload, as: :json, headers: @headers

      expect(response.status).to eq 401

      expect(response.body).to match(/API key invalid/)
    end

    it 'gives an error if the api_key is missing' do
      @json_payload[:api_key] = nil
      post '/api/v1/road_trip', params: @json_payload, as: :json, headers: @headers

      expect(response.status).to eq 401

      expect(response.body).to match(/API key must be sent with request/)
    end

    it "travel time and weather_at_eta becone default if trip is immpossible" do
      @json_payload[:origin] = 'Washington,DC'
      @json_payload[:destination] = 'Paris,FR'
      post '/api/v1/road_trip', params: @json_payload, as: :json, headers: @headers

      expect(response.status).to eq 200

      info = JSON.parse(response.body, symbolize_names: true)
      data = info[:data]
      attributes = data[:attributes]

      expect(attributes[:travel_time]).to eq 'impossible'
      expect(attributes[:weather]).to be_nil
    end
  end
end
