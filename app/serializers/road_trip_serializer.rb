class RoadTripSerializer
  class << self
    def trip(route)
      {
        data: {
          id: nil,
          type: 'roadtrip',
          attributes: {
            start_city: route.start_city,
            end_city: route.end_city,
            travel_time: travel_time(route),
            weather_at_eta: weather(route)
          }
        }
      }
    end

    def travel_time(route)
      if route.trip_time
        route.trip_time_f
      else
        'impossible'
      end
    end

    def weather(route)
      route.weather if route.trip_time
    end
  end
end