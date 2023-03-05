class CountryFacade

  def self.get_random_country(countries)
    country_results = CountryService.get_countries
    country = Country.new(country_results.sample[:name])
  end
end