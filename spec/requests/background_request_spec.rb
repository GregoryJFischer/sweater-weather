require 'rails_helper'

describe 'background requests', :vcr do
  describe 'GET /api/v1/backgrounds' do
    it 'can get a background image based on search parameters' do
      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
       }
       params = { location: 'Los Angeles,CA' }

       get '/api/v1/backgrounds', params: params, headers: headers

       expect(response.status).to eq 200

       info = JSON.parse(response.body, symbolize_names: true)
       image = info[:data][:attributes][:image]
       credit = image[:credit]

       expect(info).to have_key :data

       expect(info[:data][:type]).to eq 'image'
       expect(info[:data][:id]).to be_nil
       expect(info[:data][:attributes]).to have_key :image

       expect(image[:location]).to eq params[:location]
       expect(image[:image_url]).to be_a String

       expect(credit[:source]).to eq 'Unsplash'
       expect(credit[:source_url]).to eq 'https://unsplash.com/?utm_source=sweater-weather-api&utm_medium=referral'
       expect(credit[:photographer]).to be_a String
       expect(credit[:photographer_link]).to be_a String
    end
  end
end