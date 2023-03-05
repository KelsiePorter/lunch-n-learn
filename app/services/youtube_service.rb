class YoutubeService 

  def self.get_video(query)
    response = conn.get("/youtube/v3/search?q=#{query}")
    parse_json(response)
  end

  private 

  def self.conn 
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.params['part'] = "snippet"
      f.params['maxResults'] = 1
      f.params['key'] = ENV['youtube_api_key']
      f.params['channelId'] = 'UCluQ5yInbeAkkeCndNnUhpw'
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end