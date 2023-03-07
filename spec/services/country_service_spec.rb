require 'rails_helper'

RSpec.describe CountryService do 
  it 'returns a collection of all countries' do 
    stub_request(:get, "https://restcountries.com/v3.1/all")
    .to_return(status: 200, body: File.read('./spec/fixtures/_all_countries.json'), headers: {})
    response = CountryService.get_countries

    expect(response).to be_an Array
    expect(response.length).to eq(250)
    expect(response[0]).to have_key(:name)
    expect(response[0][:name]).to have_key(:common)
    expect(response[0][:name][:common]).to be_a String
  end

  it 'returns longitude and latitude of the capital city' do 
    stub_request(:get, "https://restcountries.com/v3.1/name/peru")
      .to_return(status: 200, body: File.read('./spec/fixtures/peru_data.json'), headers: {})
    country = 'peru'
    response = CountryService.get_long_lat_capital_city(country)
    
    expect(response).to be_an Array
    expect(response.length).to eq(2)
    expect(response[0]).to be_a Float
    expect(response[1]).to be_a Float
  end
end