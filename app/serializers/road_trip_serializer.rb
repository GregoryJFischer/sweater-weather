class RoadTripSerializer
  def self.trip(route)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: route.start_city,
          end_city: route.end_city,
          travel_time: route.trip_time_f,
          weather_at_eta: route.weather
        }
       }
     }
  end
end