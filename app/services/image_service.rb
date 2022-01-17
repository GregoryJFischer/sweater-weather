class ImageService
  attr_reader :location

  def initialize(search)
    @image = Unsplash::Photo.search(search, page = 1, per_page = 1).first
    @location = search
  end

  def url
    @image.urls.raw
  end

  def photographer
    @image.user.name
  end

  def photographer_link
    "https://unsplash.com/@#{@image.user.username}?utm_source=sweater-weather-api&utm_medium=referral"
  end

  def source
    'Unsplash'
  end

  def source_url
    'https://unsplash.com/?utm_source=sweater-weather-api&utm_medium=referral'
  end
end