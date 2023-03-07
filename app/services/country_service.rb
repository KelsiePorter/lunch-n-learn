class CountryService 

  def self.get_countries
    response = conn.get("/v3.1/all")
    parse_json(response)
  end

  def self.get_long_lat_capital_city(country)
    response = conn.get("/v3.1/name/#{country}")
    country_data = parse_json(response)
    country_data[0][:capitalInfo][:latlng].reverse
  end

  private

  def self.conn
    Faraday.new(url: 'https://restcountries.com')
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end