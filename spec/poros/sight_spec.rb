require 'rails_helper'

RSpec.describe Sight do 
  it 'exists and has attributes' do 
    sight_data = File.read('./spec/fixtures/single_lima_tourist_sight.json')
    parsed_sight_data = JSON.parse(sight_data, symbolize_names: true)

    sight = Sight.new(parsed_sight_data)

    expect(sight).to be_an_instance_of(Sight)
    expect(sight.name).to eq("Complejo Arqueológico Mateo Salado")
    expect(sight.address).to eq("Complejo Arqueológico Mateo Salado, Mariano Cornejo Avenue, Lima, Lima Metropolitan Area 15084, Peru")
    expect(sight.place_id).to eq("516539f56d054453c059c8406d6eb62128c0f00102f90141bbe90600000000920323436f6d706c656a6f2041727175656f6cc3b36769636f204d6174656f2053616c61646f")
  end
end