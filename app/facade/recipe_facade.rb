class RecipeFacade 
  def self.get_recipes_by_country(query) 
    search_results = RecipeService.get_recipes_by_country(query)
    search_results[:hits].map do |recipe_data, query|
      Recipe.new(recipe_data, query)
    end
  end
end