class Api::V1::BackgroundsController < ApplicationController
  def index
    image = ImageService.new(params[:location])
    render json: ImageSerializer.image(image)
  end
end