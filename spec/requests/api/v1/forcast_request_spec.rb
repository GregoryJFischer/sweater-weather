require 'rails_helper'

describe 'forcast requests', :vcr do
  describe 'GET /forcast' do
    it 'can return weather data for a location' do
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      get '/api/v1/forecast?location=denver,co', headers: headers

      info = JSON.parse(response.body, symbolize_names: true)
      data = info[:data]
      attributes = data[:attributes]

      expect(response.status).to eq 200

      expect(data[:id]).to be_nil
      expect(data[:type]).to eq 'forecast'

      expect(attributes).to have_key :current_weather
      expect(attributes[:current_weather]).to be_a Hash

      current_weather = attributes[:current_weather]

      expect(current_weather[:datetime]).to be_a String
      expect(current_weather[:sunrise]).to be_a String
      expect(current_weather[:sunset]).to be_a String
      expect(current_weather[:temperature]).to be_a Float
      expect(current_weather[:feels_like]).to be_a Float
      expect(current_weather[:humidity]).to be_a Integer
      expect(current_weather[:uvi]).to be_a Integer
      expect(current_weather[:visibility]).to be_a Integer
      expect(current_weather[:conditions]).to be_a String
      expect(current_weather[:icon]).to be_a String

      expect(current_weather).to_not have_key :pressure
      expect(current_weather).to_not have_key :dew_point
      expect(current_weather).to_not have_key :clouds
      expect(current_weather).to_not have_key :wind_speed
      expect(current_weather).to_not have_key :wind_deg

      expect(attributes).to have_key :daily_weather
      expect(attributes[:daily_weather]).to be_a Array
      expect(attributes[:daily_weather].length).to eq 5

      daily_weather = attributes[:daily_weather][0]

      expect(daily_weather[:date]).to be_a String
      expect(daily_weather[:sunrise]).to be_a String
      expect(daily_weather[:sunset]).to be_a String
      expect(daily_weather[:max_temp]).to be_a Float
      expect(daily_weather[:min_temp]).to be_a Float
      expect(daily_weather[:conditions]).to be_a String
      expect(daily_weather[:icon]).to be_a String

      expect(daily_weather).to_not have_key :moonrise
      expect(daily_weather).to_not have_key :moonset
      expect(daily_weather).to_not have_key :moon_phase
      expect(daily_weather).to_not have_key :feels_like
      expect(daily_weather).to_not have_key :pressure
      expect(daily_weather).to_not have_key :humidity
      expect(daily_weather).to_not have_key :dew_point
      expect(daily_weather).to_not have_key :wind_speed
      expect(daily_weather).to_not have_key :wind_deg
      expect(daily_weather).to_not have_key :clouds
      expect(daily_weather).to_not have_key :pop
      expect(daily_weather).to_not have_key :rain
      expect(daily_weather).to_not have_key :uvi

      expect(attributes).to have_key :hourly_weather
      expect(attributes[:hourly_weather]).to be_a Array
      expect(attributes[:hourly_weather].length).to eq 8

      hourly_weather = attributes[:hourly_weather][0]

      expect(hourly_weather[:time]).to be_a String
      expect(hourly_weather[:temperature]).to be_a Float
      expect(hourly_weather[:conditions]).to be_a String
      expect(hourly_weather[:icon]).to be_a String

      expect(hourly_weather).to_not have_key :feels_like
      expect(hourly_weather).to_not have_key :pressure
      expect(hourly_weather).to_not have_key :humidity
      expect(hourly_weather).to_not have_key :dew_point
      expect(hourly_weather).to_not have_key :uvi
      expect(hourly_weather).to_not have_key :clouds
      expect(hourly_weather).to_not have_key :visibility
      expect(hourly_weather).to_not have_key :wind_speed
      expect(hourly_weather).to_not have_key :wind_deg
      expect(hourly_weather).to_not have_key :wind_gust
      expect(hourly_weather).to_not have_key :pop
    end

    it 'can get the weather with metric units' do
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      get '/api/v1/forecast?location=denver,co', headers: headers

      imperial_info = JSON.parse(response.body, symbolize_names: true)
      imperial_temp = imperial_info[:data][:attributes][:current_weather][:temperature]

      get '/api/v1/forecast?location=denver,co&units=metric', headers: headers

      metric_info = JSON.parse(response.body, symbolize_names: true)
      metric_temp = metric_info[:data][:attributes][:current_weather][:temperature]
      comp_temp = (metric_temp * 1.8 + 32.0).round

      expect(imperial_temp.round).to eq comp_temp
    end
  end
end