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
    @image.user.links.self
  end

  def source
    'unsplash.com/?utm_source=sweater-weather-api&utm_medium=referral'
  end
end