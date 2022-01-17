class WeatherService
  class << self
    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_weather(latLng, units = 'imperial')
      parse(Faraday.get('https://api.openweathermap.org/data/2.5/onecall', {lat: latLng[:lat], lon: latLng[:lng], units: units, appid: ENV['weather_key'], exclude: 'minutely,alerts'}))
    end
  end
end