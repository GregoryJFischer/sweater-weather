FactoryBot.define do
  factory :key do
    value { Faker::Alphanumeric.alphanumeric(number: 16) }
    user
  end
end