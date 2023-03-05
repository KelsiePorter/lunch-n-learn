require 'rails_helper'

RSpec.describe 'REST Countries API' do 
  it 'returns a collection of all countries' do 
    stub_request(:get, "https://restcountries.com/v3.1/all")
    .to_return(status: 200, body: File.read('./spec/fixtures/all_countries.json'), headers: {})
    response = CountryService.get_countries

    expect(response).to be_an Array
    expect(response.length).to eq(250)
    expect(response[0]).to have_key(:name)
    expect(response[0][:name]).to have_key(:common)
  end
end