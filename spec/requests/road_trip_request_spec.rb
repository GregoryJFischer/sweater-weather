require 'rails_helper'

describe 'road trip requests' do
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

        
      end
    end
  end
end