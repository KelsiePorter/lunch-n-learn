require 'rails_helper'

RSpec.describe RecipeFacade do 
  before :each do 
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{ENV['edamam_app_id']}&app_key=#{ENV['edamam_app_key']}&q=peru&type=public")
    .to_return(status: 200, body: File.read('./spec/fixtures/recipes_by_country.json'), headers: {})
  end

  describe '.get_recipes_by_country' do 
    it 'returns an array of recipe objects' do
      country = 'peru'
      recipes = RecipeFacade.get_recipes_by_country(country)

      expect(recipes).to be_an Array
      recipes.each do |recipe|
        expect(recipe).to be_an_instance_of(Recipe)
      end
    end
  end
end