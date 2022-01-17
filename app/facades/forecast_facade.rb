class ForecastFacade
  class << self
    def weather(info)
      weather_service(info)
    end

    def weather_service(info)
      latLng = map_service(info)
      if info[:units]
        WeatherService.get_weather(latLng, info[:units])
      else
        WeatherService.get_weather(latLng)
      end
    end

    def map_service(info)
        MapService.get_coordinates(info[:location])
    end
  end
end