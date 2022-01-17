require 'rails_helper'

describe WeatherService, :vcr do
  describe 'get_weather' do
    it 'can get a hash with weather data' do
      latLng = MapService.get_coordinates('Washington,DC')
      data = WeatherService.get_weather(latLng)

      expect(data).to be_a Hash

      expect(data).to_not have_key :minutely
      expect(data).to_not have_key :alerts

      expect(data).to have_key :current
      expect(data[:current]).to have_key :dt
      expect(data[:current]).to have_key :sunrise
      expect(data[:current]).to have_key :sunset
      expect(data[:current]).to have_key :temp
      expect(data[:current]).to have_key :feels_like
      expect(data[:current]).to have_key :humidity
      expect(data[:current]).to have_key :uvi
      expect(data[:current]).to have_key :visibility
      expect(data[:current][:weather][0]).to have_key :description
      expect(data[:current][:weather][0]).to have_key :icon

      expect(data).to have_key :daily
      expect(data[:daily][0]).to have_key :dt
      expect(data[:daily][0]).to have_key :sunrise
      expect(data[:daily][0]).to have_key :sunset
      expect(data[:daily][0][:temp]).to have_key :max
      expect(data[:daily][0][:temp]).to have_key :min
      expect(data[:daily][0][:weather][0]).to have_key :description
      expect(data[:daily][0][:weather][0]).to have_key :icon

      expect(data).to have_key :hourly
      expect(data[:hourly][0]).to have_key :dt
      expect(data[:hourly][0]).to have_key :temp
      expect(data[:hourly][0][:weather][0]).to have_key :description
      expect(data[:hourly][0][:weather][0]).to have_key :icon
    end

    it 'can get the weather with different units' do
      latLng = MapService.get_coordinates('Washington,DC')
      imperial = WeatherService.get_weather(latLng)
      metric = WeatherService.get_weather(latLng, 'metric')

      imperial_temp = ((imperial[:current][:temp] - 32.0) * (5.0/9.0)).round(2)
      metric_temp = metric[:current][:temp]

      expect(imperial_temp).to eq metric_temp
    end
  end
end