require 'rails_helper'

RSpec.describe 'Places API' do 
  before :each do 
    WebMock.allow_net_connect!
  end

  it 'returns a collection of tourist sight within 1000m of the specified country' do 
    country = 'france'
    get "/api/v1/tourist_sights?country=#{country}"

    search_results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(search_results).to have_key(:data)
    expect(search_results[:data]).to be_an Array

    search_results[:data].each do |result|
      expect(result).to have_key(:id)
      expect(result[:id]).to eq('null')
      expect(result).to have_key(:type)
      expect(result[:type]).to eq('tourist_sight')
      expect(result).to have_key(:attributes)
      expect(result[:attributes]).to be_a Hash
      expect(result[:attributes]).to have_key(:name)
      expect(result[:attributes][:name]).to be_a String
      expect(result[:attributes]).to have_key(:address)
      expect(result[:attributes][:address]).to be_a String
      expect(result[:attributes]).to have_key(:place_id)
      expect(result[:attributes][:place_id]).to be_a String

      expect(result[:attributes]).to_not have_key(:country)
      expect(result[:attributes]).to_not have_key(:lon)
      expect(result[:attributes]).to_not have_key(:lat)
    end
  end
end