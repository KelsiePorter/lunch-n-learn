require 'rails_helper'

RSpec.describe RecipeService do
  describe '.get_recipes' do 
    it 'returns a response with recipes for a specified country' do 
      stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{ENV['edamam_app_id']}&app_key=#{ENV['edamam_app_key']}&q=peru&type=public")
      .to_return(status: 200, body: File.read('./spec/fixtures/recipes_by_country.json'), headers: {})
      country = 'peru'
      response = RecipeService.get_recipes_by_country(country)
y
      expect(response).to be_a Hash
      expect(response).to have_key(:hits)
      expect(response[:hits]).to be_an Array
      expect(response[:hits].length).to eq(20)
      expect(response[:hits][0]).to have_key(:recipe)
      expect(response[:hits][0][:recipe]).to be_a Hash
      expect(response[:hits][0][:recipe]).to have_key(:label)
      expect(response[:hits][0][:recipe][:label]).to be_a String
      expect(response[:hits][0][:recipe]).to have_key(:url)
      expect(response[:hits][0][:recipe][:url]).to be_a String
      expect(response[:hits][0][:recipe]).to have_key(:image)
      expect(response[:hits][0][:recipe][:image]).to be_a String
    end

    it 'returns an empty array if no recipes are found' do 
      stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{ENV['edamam_app_id']}&app_key=#{ENV['edamam_app_key']}&q=&type=public")
      .to_return(status: 200, body: File.read('./spec/fixtures/no_matching_recipes.json'), headers: {})
      country = ''
      response = RecipeService.get_recipes_by_country(country)
      
      expect(response).to be_a Hash
      expect(response[:hits]).to eq([])
    end
  end
end