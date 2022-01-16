require 'rails_helper'

describe MapService, :vcr do
  describe 'get_coordinates' do
    it 'returns just the coordinates of the address given' do
      latLng = MapService.get_coordinates('Washington,DC')

      expect(latLng).to be_a Hash
      expect(latLng[:lat]).to be 38.892062
      expect(latLng[:lng]).to be(-77.019912)
    end

    it 'returns error messages if parameters are invalid' do
      latLng = MapService.get_coordinates('')

      expect(latLng).to be_a Array
      expect(latLng[0]).to eq 'Illegal argument from request: Insufficient info for location'
    end
  end
end