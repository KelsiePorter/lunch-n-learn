require 'rails_helper'

RSpec.describe 'Places API' do 
  before :each do 
    WebMock.allow_net_connect!
  end

  it 'returns a collection of tourist sights within 1000m of the specified country' do 
    stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=#{ENV['places_api_key']}&categories=tourism.sights&filter=circle:-77.05,-12.05,1000&limit=20")
      .to_return(status: 200, body: File.read('./spec/fixtures/lima_tourist_sights.json'), headers: {})
    country = 'peru'
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