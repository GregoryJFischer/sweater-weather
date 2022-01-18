class BookSerializer
  class << self
    def books(info)
      {
        data: {
          id: nil,
          type: 'books',
          attributes: {
            destination: info.location,
            forecast: info.forecast,
            total_books_found: info.total_books_found,
            books: books_array(info.books)
          }
        }
      }
    end

    def books_array(book_info)
      book_info.map do |book|
        {
          isbn: book.isbn,
          title: book.title,
          publisher: book.publisher
         }
      end
    end
  end
end