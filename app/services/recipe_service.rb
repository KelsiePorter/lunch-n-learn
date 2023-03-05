class RecipeService 
  def self.get_recipes_by_country(query)
    response = conn.get("/api/recipes/v2?type=public&q=#{query}&app_id=#{ ENV['edamam_app_id']}&app_key=#{ ENV['edamam_app_key']}")
    parse_json(response)
  end

  private 

  def self.conn
    Faraday.new(url: 'https://api.edamam.com')
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end