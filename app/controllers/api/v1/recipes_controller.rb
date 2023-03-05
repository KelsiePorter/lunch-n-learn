class Api::V1::RecipesController < ApplicationController
  def index
    if params[:country] = nil
      #call on country search api to get a collection back
      #call .sample on collection and save that to country 
      #variable. Now pass the country variable into the 
      #recipe facade
      # country = 
      # results = RecipeFacade.get_recipes_by_country(country)
    else
      results = RecipeFacade.get_recipes_by_country(params[:country])
    end

    render json: RecipeResultSerializer.new(results)
  end
end

# if params[:q].present?
#   results = MediaFacade.search(params[:q], params[:user_id])
# else
#   results = []
# end
# render json: SearchResultSerializer.new(results)
# end