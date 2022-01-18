require 'rails_helper'

describe 'book requests', :vcr do
  it 'returns a JSON with weather and books' do
    get '/api/v1/book-search?location=Cigago,IL&quantity=8'

    expect(response.status).to eq 200

    hash = JSON.parse(response.body, symbolize_names: true)
    data = hash[:data]
    attributes = data[:attributes]

    expect(data[:id]).to be_nil
    expect(data[:type]).to eq 'books'
    expect(attributes[:destination]).to be_a String
    expect(attributes[:forecast][:summary]).to be_a String
    expect(attributes[:forecast][:temperature]).to be_a Float
    expect(attributes[:total_books_found]).to be_a Integer
    expect(attributes[:books]).to be_a Array
    expect(attributes[:books].size).to eq 8
  end
end
