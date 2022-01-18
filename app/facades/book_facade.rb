class BookFacade
  attr_reader :location

  def initialize(search_params)
    @location = search_params[:location]
    @quantity = search_params[:quantity]
    @book_results = LibraryService.get_books(search_params[:location], search_params[:quantity])
  end

  def total_books_found
    @book_results[:numFound]
  end

  def books
    @book_results[:docs].map do |book|
      Book.new(book)
    end
  end

  def forecast
    weather = weather_service
    {
      summary: weather[:current][:weather][0][:description],
      temperature: weather[:current][:temp]
     }
  end

  def weather_service
    latLng = map_service(@location)
    WeatherService.get_weather(latLng)
  end

  def map_service(location)
    MapService.get_coordinates(location)
  end
end