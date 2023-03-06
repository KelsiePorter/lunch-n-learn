class Api::V1::TouristSightsController < ApplicationController 
  
  def index
    results = TouristSightsFacade.get_tourist_sights(params[:country])
    render json: TouristSightSerializer.new(results)
  end
end