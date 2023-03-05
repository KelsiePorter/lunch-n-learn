require 'rails_helper'

RSpec.describe Country do 
  it 'exists and has an attribute' do 
    country_data = {
      :common=>"Nauru",
      :official=>"Republic of Nauru",
      :nativeName=>{:eng=>{:official=>"Republic of Nauru", :common=>"Nauru"}, :nau=>{:official=>"Republic of Nauru", :common=>"Nauru"}}
    }

    country = Country.new(country_data)

    expect(country).to be_an_instance_of(Country)
    expect(country.country_name).to eq("nauru")
    expect(country.country_name).to be_a String
  end
end
