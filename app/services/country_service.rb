class CountryService 

  def self.get_countries
    response = conn.get("/v3.1/all")
    parse_json(response)
  end

  private

  def self.conn
    Faraday.new(url: 'https://restcountries.com')
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end