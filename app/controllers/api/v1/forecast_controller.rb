class Api::V1::ForecastController < ApplicationController
  def index
    data = ForecastFacade.weather(forcast_params)
    render json: ForecastSerializer.weather(data)
  end

  private

  def forcast_params
    params.permit(:location, :units)
  end
end