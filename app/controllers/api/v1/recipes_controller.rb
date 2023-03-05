class Api::V1::RecipesController < ApplicationController
  def index
    if params[:country]
      results = RecipeFacade.get_recipes_by_country(params[:country])
    else
      country = CountryFacade.get_random_country
      results = RecipeFacade.get_recipes_by_country(country.country_name)
    end

    render json: RecipeSerializer.new(results)
  end
end