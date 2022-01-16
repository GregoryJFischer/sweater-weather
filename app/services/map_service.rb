class MapService
  class << self
    def conn
      Faraday.new('http://www.mapquestapi.com')
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_coordinates(location)
      data = parse(conn.get('/geocoding/v1/address', {key: ENV['map_key'], location: location}))
      if data[:info][:messages].empty?
        data[:results][0][:locations][0][:latLng]
      else
        data[:info][:messages]
      end
    end
  end
end