require 'rails_helper'

describe Key, type: :model do
  describe 'validations' do
    it {should validate_uniqueness_of :value}
  end

  describe 'relationships' do
    it {should belong_to :user}
  end

  describe 'initialization' do
    it 'should create a random value when created' do
      user = create(:user)
      key = user.keys.create

      expect(key.value).to_not be_nil
      expect(key.value).to be_a String
    end
  end
end