require 'rails_helper'

describe Book do
  before :each do
    @info = {
      isbn: [ Faker::Code.isbn, Faker::Code.isbn ],
      title: Faker::Lorem.word,
      publisher: [Faker::Company.name, Faker::Company.name, Faker::Company.name]
     }
     @book = Book.new(@info)
  end

  it 'creates a book with readable attributes' do
    expect(@book).to be_a Book

    expect(@book.isbn).to eq @info[:isbn]
    expect(@book.title).to eq @info[:title]
    expect(@book.publisher).to eq @info[:publisher]
  end
end