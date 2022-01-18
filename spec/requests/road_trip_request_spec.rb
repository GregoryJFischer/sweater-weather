require 'rails_helper'

describe 'road trip requests', :vcr do
  describe 'POST /api/v1/road_trip' do
    before :each do
      user = create(:user)
      api_key = user.keys.first
      @headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
      @json_payload = {
        origin: 'Washington,DC',
        destination: 'Boston,MA',
        api_key: api_key
      }

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
    end
  end
end