require 'rails_helper'

RSpec.describe CountryFacade do 
  before :each do 
    stub_request(:get, "https://restcountries.com/v3.1/all")
    .to_return(status: 200, body: File.read('./spec/fixtures/all_countries.json'), headers: {})
  end

  it 'returns a single country object' do 
    country = CountryFacade.get_random_country

    expect(country).to be_an_instance_of(Country)
  end
end