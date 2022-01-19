require 'rails_helper'

describe ForecastFacade, :vcr do
  it 'calls the weather and map services to get weather data' do
    weather = ForecastFacade.weather({location: 'Washington,DC'})

    expect(weather).to be_a Hash

    expect(weather).to_not have_key :minutely
    expect(weather).to_not have_key :alerts

    expect(weather).to have_key :current
    expect(weather[:current]).to have_key :dt
    expect(weather[:current]).to have_key :sunrise
    expect(weather[:current]).to have_key :sunset
    expect(weather[:current]).to have_key :temp
    expect(weather[:current]).to have_key :feels_like
    expect(weather[:current]).to have_key :humidity
    expect(weather[:current]).to have_key :uvi
    expect(weather[:current]).to have_key :visibility
    expect(weather[:current][:weather][0]).to have_key :description
    expect(weather[:current][:weather][0]).to have_key :icon

    expect(weather).to have_key :daily
    expect(weather[:daily][0]).to have_key :dt
    expect(weather[:daily][0]).to have_key :sunrise
    expect(weather[:daily][0]).to have_key :sunset
    expect(weather[:daily][0][:temp]).to have_key :max
    expect(weather[:daily][0][:temp]).to have_key :min
    expect(weather[:daily][0][:weather][0]).to have_key :description
    expect(weather[:daily][0][:weather][0]).to have_key :icon

    expect(weather).to have_key :hourly
    expect(weather[:hourly][0]).to have_key :dt
    expect(weather[:hourly][0]).to have_key :temp
    expect(weather[:hourly][0][:weather][0]).to have_key :description
    expect(weather[:hourly][0][:weather][0]).to have_key :icon
  end

  it 'can get the weather with different units' do
    imperial = ForecastFacade.weather({location: 'Washington,DC'})
    metric = ForecastFacade.weather({location: 'Washington,DC', units: 'metric'})

    imperial_temp = ((imperial[:current][:temp] - 32.0) * (5.0/9.0)).round(2)
    metric_temp = metric[:current][:temp]

    expect(imperial_temp).to eq metric_temp
  end
end