Unsplash.configure do |config|
  config.application_access_key = ENV['unsplash_key']
  config.application_secret = ENV['unsplash_sectret']
  config.utm_source = "sweater-weather-api"
end