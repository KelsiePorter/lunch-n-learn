class TouristSight 
  attr_reader :name,
              :address,
              :place_id

  def initialize(sight_data)
    @name = sight_data[:properties][:name]
    @address = sight_data[:properties][:formatted]
    @place_id = sight_data[:properties][:place_id]
  end
end