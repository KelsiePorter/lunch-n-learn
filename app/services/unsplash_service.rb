class UnsplashService
  def self.get_images(query)
    response = conn.get("/search/photos?query=#{query}")
    parse_json(response)
  end

  private 

  def self.conn 
    Faraday.new(url: 'https://api.unsplash.com') do |f|
      f.params['client_id'] = ENV['unsplash_access_key']
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end