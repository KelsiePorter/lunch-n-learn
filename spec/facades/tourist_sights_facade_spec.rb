require 'rails_helper'

RSpec.describe TouristSightsFacade do
  it 'returns a collection of tourist sight objects' do 
    stub_request(:get, "https://restcountries.com/v3.1/name/peru")
    .to_return(status: 200, body: File.read('./spec/fixtures/peru_data.json'), headers: {})

    stub_request(:get, "https://api.geoapify.com/v2/places?categories=tourism.sights&filter=circle:-77.05,-12.05,1000&limit=20&apiKey=#{ENV['places_api_key']}")
    .to_return(status: 200, body: File.read('./spec/fixtures/lima_tourist_sights.json'), headers: {})
    country = 'peru'
    tourist_sights = TouristSightsFacade.get_tourist_sights(country)

    expect(tourist_sights).to be_an Array

    tourist_sights.each do |tourist_sight|
      expect(tourist_sight).to be_an_instance_of(TouristSight)
    end
  end
end