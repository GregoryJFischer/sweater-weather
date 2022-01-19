class Api::V1::RoadTripsController < ApplicationController
  def index
    # following lines refactored when user levels implimented
    key = Key.find_by(value: params[:api_key])
    road_trip = RoadTripFacade.new(params[:origin], params[:destination])

    if params[:api_key] == nil
      render json: { error: 'API key must be sent with request.'}, status: 401
    elsif key == nil
      render json: { error: 'API key invalid.'}, status: 401
    else
      render json: RoadTripSerializer.trip(road_trip)
    end
  end
end