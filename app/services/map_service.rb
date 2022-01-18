class MapService
  class << self
    def conn
      Faraday.new('http://www.mapquestapi.com')
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_coordinates(location)
      Rails.cache.fetch("Coordinates-#{location}", expires_in: 1.day) do
        data = parse(conn.get('/geocoding/v1/address', {key: ENV['map_key'], location: location}))
        if data[:info][:messages].empty?
          data[:results][0][:locations][0][:latLng]
        else
          data[:info][:messages]
        end
      end
    end

    def formated_lat_lng(location)
      latLng = get_coordinates(location)
      "#{latLng[:lat]},#{latLng[:lng]}"
    end

    def get_route(from_city, to_city)
      from = formated_lat_lng(from_city)
      to = formated_lat_lng(to_city)

      parse(conn.get('/directions/v2/route', {key: ENV['map_key'], from: from, to: to}))
    end
  end
end