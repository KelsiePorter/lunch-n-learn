require 'rails_helper'
RSpec.describe 'User API' do
  it 'can create a new user' do 
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    body = { name: "Athena Dao", email: "athenadao@bestgirlever.com" }
    post '/api/v1/users', params: body.to_json, headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(201)

    new_user = User.last
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(new_user.name).to eq(body[:name])
    expect(new_user.email).to eq(body[:email])

    expect(parsed_response).to have_key(:data)
    expect(parsed_response[:data]).to be_a Hash
    expect(parsed_response[:data]).to have_key(:id)
    expect(parsed_response[:data]).to have_key(:type)
    expect(parsed_response[:data][:type]).to eq('user')
    expect(parsed_response[:data]).to have_key(:attributes)
    expect(parsed_response[:data][:attributes]).to have_key(:name)
    expect(parsed_response[:data][:attributes][:name]).to eq(new_user.name)
    expect(parsed_response[:data][:attributes]).to have_key(:email)
    expect(parsed_response[:data][:attributes][:email]).to eq(new_user.email)
    expect(parsed_response[:data][:attributes]).to have_key(:api_key)
    expect(parsed_response[:data][:attributes][:api_key]).to eq(new_user.api_key)
  end

  it 'will have an error response if email passed is not unique' do 
    existing_user = User.create(name: "Athena Dao", email: "athenadao@bestgirlever.com", api_key: '521dfhpq84bde641Vy98wPnc78g')
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    body = { name: "Athena McDao", email: "athenadao@bestgirlever.com" }
    post '/api/v1/users', params: body.to_json, headers: headers
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
    expect(parsed_response[:errors]).to eq('Email has already been taken')
  end

  it 'will have an error response if missing attributes in request' do 
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    body = { name: "", email: "athenadao@bestgirlever.com" }
    post '/api/v1/users', params: body.to_json, headers: headers
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
    expect(parsed_response[:errors]).to eq("Name can't be blank")
  end
end