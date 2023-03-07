require 'rails_helper'

RSpec.describe PlacesService do 
  it 'returns tourist sights within a 1000m radius of the specified coordinates' do 
    stub_request(:get, "https://api.geoapify.com/v2/places?categories=tourism.sights&filter=circle:-77.05,-12.05,1q000&limit=20&apiKey=#{ENV['places_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/lima_tourist_sights.json'), headers: {})
    coords = [-77.05,-12.05]
    response = PlacesService.get_tourist_sights(coords)

    expect(response).to be_a Hash
    expect(response).to have_key(:features)
    expect(response[:features]).to be_an Array
    expect(response[:features][0]).to have_key(:properties)
    expect(response[:features][0][:properties]).to be_a Hash
    expect(response[:features][0][:properties]).to have_key(:name)
    expect(response[:features][0][:properties][:name]).to be_a String
    expect(response[:features][0][:properties]).to have_key(:formatted)
    expect(response[:features][0][:properties][:formatted]).to be_a String
    expect(response[:features][0][:properties]).to have_key(:place_id)
    expect(response[:features][0][:properties][:place_id]).to be_a String
  end
end