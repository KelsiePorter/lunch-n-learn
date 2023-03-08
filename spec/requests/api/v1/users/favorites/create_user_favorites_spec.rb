require 'rails_helper'

RSpec.describe 'Create a User Favorite API' do 
  it 'can create a user favorite' do 
    river = User.create!(name: 'River', email: 'river@example.com', api_key: '5545siglwb9dhjN8OPsdh40cVV1')

    expect(river.favorites.count).to eq(0)

    body = { api_key: river.api_key, country: "peru", recipe_link: "http://www.edamam.com/ontologies/edamam.owl#recipe_5886d047f5eb79791b059144a48eec9a", recipe_title: "Arriba Peru" }
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    post '/api/v1/favorites', params: body.to_json, headers: headers

    expect(response).to be_successful
    expect(response).to have_http_status(201)
    expect(river.favorites.count).to eq(1)

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to have_key(:success)
    expect(parsed_response[:success]).to eq("Favorite added successfully")
  end

  it 'will send an error response if no user matches api key' do 
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    body = { api_key: '5545siglwb9dhjN8OPsdh40cVV1', country: "peru", recipe_link: "http://www.edamam.com/ontologies/", recipe_title: "Spinach and Gouda Lasagna" }
    post '/api/v1/favorites', params: body.to_json, headers: headers

    expect(response).to_not be_successful
    expect(response).to have_http_status(404)

    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(error_response).to have_key(:errors)
    expect(error_response[:errors]).to eq("User not found")
  end

  it 'will send an error if not able to create a user favorite' do 
    river = User.create!(name: 'River', email: 'river@example.com', api_key: '5545siglwb9dhjN8OPsdh40cVV1')
    
    expect(river.favorites.count).to eq(0)

    body = { api_key: river.api_key, country: "", recipe_link: "", recipe_title: "" }
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    post '/api/v1/favorites', params: body.to_json, headers: headers

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
    expect(river.favorites.count).to eq(0)

    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(error_response).to have_key(:errors)
    expect(error_response[:errors]).to eq("Country can't be blank, Recipe link can't be blank, and Recipe title can't be blank")
  end
end