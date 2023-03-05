class Api::V1::RecipesController < ApplicationController
  def index
    if params[:country]
      results = RecipeFacade.get_recipes_by_country(params[:country])
    else
      #call on country search api to get a collection back
      #call .sample on collection and save that to country 
      #variable. Now pass the country variable into the 
      #recipe facade
      # country = 
      # results = RecipeFacade.get_recipes_by_country(country)
    end

    render json: RecipeSerializer.new(results)
  end
end