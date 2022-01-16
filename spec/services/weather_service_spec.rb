require 'rails_helper'

describe WeatherService, :vcr do
  describe 'get_weather' do
    it 'can get a hash with weather data' do
      latLng = MapService.get_coordinates('Washington,DC')
      data = WeatherService.get_weather(latLng)

      # such a big hash
      expect(data).to be_a Hash
    end
  end
end