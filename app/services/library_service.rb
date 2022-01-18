class LibraryService
  class << self
    def conn
      Faraday.new('http://openlibrary.org')
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_books(querry, quantity)
      parse(conn.get('/search.json', {q: querry, limit: quantity}, {Accept: 'application/json'}))
    end
  end
end