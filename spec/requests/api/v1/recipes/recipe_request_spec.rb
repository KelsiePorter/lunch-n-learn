require 'rails_helper'

RSpec.describe 'Edamam API' do 
  describe  'get recipe?q=' do 
    it 'returns a collection of recipes that correlate with the country param' do 
      country = 'Peru'

      get "api/v1/recipes?q=#{country}"

      search_result = JSON.parse(response.body, symbolize_names: true)
      
      expec(response).to be_successful
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(search_result).to be_a Hash
    end

    xit 'returns a collect of recipes that correlate with a randomly chosen country' do 

    end
  end
end

  # expect(search_result[:data]).to be_a Array
  # search_result[:data].first(15).each do |media_data|
  #   expect(media_data).to be_a Hash
  #   expect(media_data.keys.sort).to eq(%i[id type attributes].sort)
  #   expect(media_data[:id]).to be_a String
  #   expect(media_data[:type]).to eq('search_result')
  #   expect(media_data[:attributes]).to be_a Hash
  #   expect(media_data[:attributes].keys.sort).to eq(expected_keys.sort)
  #   expect(media_data[:attributes][:id]).to be_a Integer
  #   expect(media_data[:attributes][:title]).to be_a String
  #   expect(media_data[:attributes][:media_type]).to be_a String
  #   expect(media_data[:attributes][:release_year]).to be_a Integer
  #   expect(media_data[:attributes][:tmdb_id]).to be_a Integer
  #   expect(media_data[:attributes][:tmdb_type]).to be_a String
  #   expect(media_data[:attributes][:poster]).to be_a String
