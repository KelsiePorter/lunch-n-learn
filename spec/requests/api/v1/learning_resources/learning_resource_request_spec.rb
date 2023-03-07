require 'rails_helper'

RSpec.describe 'Youtube API and Unsplash API' do 
  before :each do 
    WebMock.allow_net_connect!
  end

  it 'returns a learning resource of a specified country with a video and images' do 
    country = 'peru'
    get "/api/v1/learning_resources?country=#{country}"

    search_results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(search_results).to have_key(:data)
    expect(search_results[:data]).to be_a Hash
    expect(search_results[:data]).to have_key(:id)
    expect(search_results[:data][:id]).to eq('null')
    expect(search_results[:data]).to have_key(:type)
    expect(search_results[:data][:type]).to eq("learning_resource")
    expect(search_results[:data]).to have_key(:attributes)
    expect(search_results[:data][:attributes]).to be_a Hash
    expect(search_results[:data][:attributes]).to have_key(:country)
    expect(search_results[:data][:attributes][:country]).to be_a String
    expect(search_results[:data][:attributes]).to have_key(:video)
    expect(search_results[:data][:attributes][:video]).to be_a Hash
    expect(search_results[:data][:attributes][:video]).to have_key(:title)
    expect(search_results[:data][:attributes][:video][:title]).to be_a String
    expect(search_results[:data][:attributes][:video]).to have_key(:youtube_video_id)
    expect(search_results[:data][:attributes][:video][:youtube_video_id]).to be_a String
    expect(search_results[:data][:attributes]).to have_key(:images)
    expect(search_results[:data][:attributes][:images]).to be_an Array

    search_results[:data][:attributes][:images].each do |image_data|
      # require 'pry'; binding.pry
      expect(image_data).to have_key(:alt_tag)
      expect(image_data[:alt_tag]).to be_a String
      expect(image_data).to have_key(:url)
      expect(image_data[:url]).to be_a String
    end
  end
end