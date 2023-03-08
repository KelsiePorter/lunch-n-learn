require 'rails_helper'

RSpec.describe "Get a User's Favorites API" do 
  it "can get a user's favorites" do
    river = User.create!(name: 'River', email: 'river@example.com', api_key: '5545siglwb9dhjN8OPsdh40cVV1')
    favorite1 = river.favorites.create!(country: 'Peru', recipe_link: "http://www.edamam.com/ontologies/edamam.owl#recipe_5886d047f5eb79791b059144a48eec9a", recipe_title: "Arriba Peru")
    favorite2 = river.favorites.create!(country: 'Ghana', recipe_link: "http://www.edamam.com/ontologies/edamam.owl#recipe_ffab760bed75f9221c81165d4c39d52d", recipe_title: "Eggplant and Seafood Stew from Ghana")
    favorite3 = river.favorites.create!(country: 'France', recipe_link: "http://www.edamam.com/ontologies/edamam.owl#recipe_48df011ddfee5cd4dacff1463e8701b0", recipe_title: "Herb And White Wine Granita")

    expect(river.favorites.count).to eq(3)

    get "/api/v1/favorites?api_key=#{river.api_key}"

    expect(response).to be_successful

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data].count).to eq(3)
    expect(parsed_response[:data][0][:id]).to eq(favorite1.id.to_s)
    expect(parsed_response[:data][1][:id]).to eq(favorite2.id.to_s)
    expect(parsed_response[:data][2][:id]).to eq(favorite3.id.to_s)
    expect(parsed_response[:data][0][:attributes][:recipe_title]).to eq(favorite1.recipe_title)
    expect(parsed_response[:data][0][:attributes][:recipe_link]).to eq(favorite1.recipe_link)
    expect(parsed_response[:data][0][:attributes][:country]).to eq(favorite1.country)

    parsed_response[:data].each do |favorite|
      expect(favorite).to have_key(:id)
      expect(favorite).to have_key(:type)
      expect(favorite[:type]).to eq('favorite')
      expect(favorite).to have_key(:attributes)
      expect(favorite[:attributes]).to be_a Hash
      expect(favorite[:attributes]).to have_key(:recipe_title)
      expect(favorite[:attributes][:recipe_title]).to be_a String
      expect(favorite[:attributes]).to have_key(:recipe_link)
      expect(favorite[:attributes][:recipe_link]).to be_a String
      expect(favorite[:attributes]).to have_key(:country)
      expect(favorite[:attributes][:country]).to be_a String
      expect(favorite[:attributes]).to have_key(:created_at)
      expect(favorite[:attributes][:created_at]).to be_a String
      expect(favorite[:attributes]).to_not have_key(:user_id)
      expect(favorite[:attributes]).to_not have_key(:updated_at)
    end
  end

  it 'will return no matching user error if api_key is invalid' do 
    get '/api/v1/favorites?api_key=1234'

    expect(response).to_not be_successful
    expect(response).to have_http_status(404)

    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(error_response).to have_key(:errors)
    expect(error_response[:errors]).to eq("No matching user found")
  end

  it 'will return an empty array if user does not have any favorites' do 
    river = User.create!(name: 'River', email: 'river@example.com', api_key: '5545siglwb9dhjN8OPsdh40cVV1')

    expect(river.favorites.count).to eq(0)

    get "/api/v1/favorites?api_key=#{river.api_key}"

    expect(response).to be_successful

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to be_a Hash
    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data].count).to eq(0)
  end
end