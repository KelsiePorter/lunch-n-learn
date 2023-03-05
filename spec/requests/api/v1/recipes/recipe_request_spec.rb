require 'rails_helper'

RSpec.describe 'Edamam API' do 
  describe  'get recipe?q=' do 
    it 'returns a collection of recipes that correlate with the country param' do 
      stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{ENV['edamam_app_id']}&app_key=#{ENV['edamam_app_key']}&q=peru&type=public")
      .to_return(status: 200, body: File.read('./spec/fixtures/recipes_by_country.json'), headers: {})
      country = 'peru'
      get "/api/v1/recipes?country=#{country}"

      search_results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(search_results).to be_a Hash
      expect(search_results).to have_key(:data)
      expect(search_results[:data]).to be_an Array

      search_results[:data].each do |result|
        expect(result).to have_key(:id)
        expect(result[:id]).to eq('null')
        expect(result).to have_key(:type)
        expect(result[:type]).to eq('recipe')
        expect(result).to have_key(:attributes)
        expect(result[:attributes]).to be_a Hash
        expect(result[:attributes]).to have_key(:title)
        expect(result[:attributes][:title]).to be_a String
        expect(result[:attributes]).to have_key(:url)
        expect(result[:attributes][:url]).to be_a String
        expect(result[:attributes]).to have_key(:country)
        expect(result[:attributes][:country]).to be_a String
        expect(result[:attributes]).to have_key(:image)
        expect(result[:attributes][:image]).to be_a String
  
        expect(result[:attributes]).to_not have_key(:uri)
        expect(result[:attributes]).to_not have_key(:ingredients)
        expect(result[:attributes]).to_not have_key(:calories)
      end
    end

    xit 'returns a collection of recipes that correlate with a randomly chosen country' do 
      get '/api/v1/recipes'

      expect(response).to be_successful
  
      search_results = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
    end
  end
end

