class WeatherService
  class << self
    def conn
      Faraday.new('https://api.openweathermap.org/data/2.5')
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_weather(latLng, units = 'imperial')
      parse(Faraday.get('https://api.openweathermap.org/data/2.5/onecall', {lat: latLng[:lat], lon: latLng[:lng], units: units, appid: ENV['weather_key'], exclude: 'minutely'}))
    end
  end
end