require 'rails_helper'

RSpec.describe RecipeService do 
  describe '.get_recipes' do 
    it 'returns a response with recipes for a specified country' do 
      country = 'Peru'
      response = RecipeService.get_recipes_by_country(country)

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
  end
end