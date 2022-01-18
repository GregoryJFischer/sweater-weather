class RoadTripFacade
  attr_reader :start_city, :end_city
  def initialize(from, to)
    @route = MapService.get_route(from, to)
    @start_city = from
    @end_city = to
  end

  def weather
    latLng = MapService.get_coordinates(@end_city)
    full_weather = WeatherService.get_weather(latLng)

    if days_from_now >= 1
      {
        temperature: full_weather[:daily][days_from_now][:temp][:day],
        conditions: full_weather[:daily][days_from_now][:weather][:description]
      }
    elsif hours_from_now < 1
      {
        temperature: full_weather[:current][:temp],
        conditions: full_weather[:current][:weather][0][:description]
       }
    else
      {
        temperature: full_weather[:hourly][(hours_from_now)][:temp],
        conditions: full_weather[:hourly][(hours_from_now)][:weather][0][:description]
       }
    end
  end

  def trip_time_f
    @route[:route][:formattedTime]
  end

  def trip_time
    @route[:route][:realTime]
  end

  def hours_from_now
    (trip_time.to_f / 3600.0).round
  end

  def days_from_now
    (trip_time.to_f / 86400.0).round
  end

  def messages
    @route[:messages]
  end
end