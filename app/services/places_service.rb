class PlacesService

  def self.get_tourist_sights(capital_city_coords)
    response = conn.get("/v2/places?categories=tourism.sights&filter=circle:#{capital_city_coords[0]},#{capital_city_coords[1]},5000&limit=20&apiKey=#{ENV['places_api_key']}")
    parse_json(response)
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.geoapify.com')
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end