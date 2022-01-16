class UserSerializer
  include JSONAPI::Serializer

  attribute :email

  attribute :api_key do |user|
    user.keys.first.value
  end
end