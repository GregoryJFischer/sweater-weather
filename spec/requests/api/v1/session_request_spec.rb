require 'rails_helper'

describe 'session requests' do
  describe 'POST api/v1/sessions' do
    before :each do
      @user = create(:user, password: 'password')
      @headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
      @json_payload = {
        email: @user.email,
        password: "password",
      }
    end

    it 'returns user info with a successful login' do
      post '/api/v1/sessions', params: @json_payload, as: :json, headers: @headers

      body = JSON.parse(response.body, symbolize_names: true)
      attributes = body[:data][:attributes]

      expect(response.status).to eq 200

      expect(body[:data][:id]).to eq @user.id.to_s
      expect(attributes[:email]).to eq @user.email
      expect(attributes[:api_key]).to_not be_nil
      expect(attributes[:api_key]).to be_a String
    end

    it 'returns an error if the password is incorrect' do
      @json_payload[:password] = 'not_password'
      post '/api/v1/sessions', params: @json_payload, as: :json, headers: @headers

      expect(response.status).to eq 401
      expect(response.body).to match(/Invalid Credentials/)
    end

    it 'returns an error if email is incorrect' do
      @json_payload[:email] = 'incorrect'
      post '/api/v1/sessions', params: @json_payload, as: :json, headers: @headers

      expect(response.status).to eq 401
      expect(response.body).to match(/Invalid Credentials/)
    end

    it 'returns an error if all data is missing' do
      post '/api/v1/sessions', params: {}, as: :json, headers: @headers

      expect(response.status).to eq 401
      expect(response.body).to match(/Invalid Credentials/)
    end
  end
end