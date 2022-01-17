require 'rails_helper'

describe ImageService, :vcr do
  it 'returns an image for a given search term' do
    image = ImageService.new('Chicago,IL')

    expect(image.url).to eq 'https://images.unsplash.com/photo-1602276506752-cec706667215?ixid=MnwyOTExNzZ8MHwxfHNlYXJjaHwxfHxDaGljYWdvJTJDSUx8ZW58MHx8fHwxNjQyNDM3OTIx&ixlib=rb-1.2.1&utm_source=sweater-weather-api&utm_medium=referral&utm_campaign=api-credit'
    expect(image.photographer).to eq 'Dylan LaPierre'
    expect(image.photographer_link).to eq 'https://unsplash.com/@drench777?utm_source=sweater-weather-api&utm_medium=referral'
    expect(image.source).to eq 'Unsplash'
    expect(image.source_url).to eq 'https://unsplash.com/?utm_source=sweater-weather-api&utm_medium=referral'
  end
end