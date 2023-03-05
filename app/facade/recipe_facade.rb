class RecipeFacade 
  def self.get_recipes_by_country(country) 
    search_results = RecipeService.get_recipes_by_country(country)
    search_results[:hits].map do |recipe_data|
      Recipe.new(country, recipe_data)
    end
  end
end