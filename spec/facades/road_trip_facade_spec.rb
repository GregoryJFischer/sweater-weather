require 'rails_helper'

describe RoadTripFacade, :vcr do
  before :each do
    @to = 'Washington, DC'
    @from = 'Reston, VA'
    @from2 = 'New York, NY'
    @from3 = 'Seatle, WA'
  end

  it 'returns info for a route' do
    route = RoadTripFacade.new(@from, @to)

    expect(route.start_city).to eq @from
    expect(route.end_city).to eq @to
    expect(route.weather).to have_key :temperature
    expect(route.weather).to have_key :conditions
    expect(route.trip_time_f).to be_a String
    expect(route.trip_time).to be_a Integer
    expect(route.hours_from_now).to be_a Integer
    expect(route.days_from_now).to be_a Integer
    expect(route.messages).to be_nil
  end

  it 'returns different weather info for different trip times' do
    route1 = RoadTripFacade.new(@from, @to)
    route2 = RoadTripFacade.new(@from2, @to)
    route3 = RoadTripFacade.new(@from3, @to)

    expect(route1.weather[:temperature]).to_not eq route2.weather[:temperature]
    expect(route1.weather[:temperature]).to_not eq route3.weather[:temperature]
    expect(route2.weather[:temperature]).to_not eq route3.weather[:temperature]
  end
end