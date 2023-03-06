class TouristSightsFacade

  def self.get_tourist_sights(country)
    capital_city_coords = CountryService.get_long_lat_capital_city(country)
    tourist_sights_data = PlacesService.get_tourist_sights(capital_city_coords)
    
    tourist_sights_data[:features].map do |sight|
      Sight.new(sight)
    end
  end
end