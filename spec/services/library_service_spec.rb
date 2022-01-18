require 'rails_helper'

describe LibraryService, :vcr do
  describe 'get_books' do
    it 'returns search results from open library' do
      books = LibraryService.get_books('Washington,DC', 5)

      expect(books).to be_a Hash

      expect(books[:numFound]).to be_a Integer
      expect(books[:docs]).to be_a Array
      expect(books[:docs].length).to eq 5
      expect(books[:docs][0][:title]).to be_a String
      expect(books[:docs][0][:isbn]).to be_a Array
      expect(books[:docs][0][:publisher]).to be_a Array
    end
  end
end