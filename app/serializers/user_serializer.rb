class UserSerializer
  include JSONAPI::Serializer

  atributes :email, :api_key
end