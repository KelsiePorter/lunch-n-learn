require 'rails_helper'

RSpec.describe LearningResourceFacade do 
  it 'returns a learning resource object with a video hash and images array' do 
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api_key']}&maxResults=1&part=snippet&q=peru")
    .to_return(status: 200, body: File.read('./spec/fixtures/peru_video_resource.json'), headers: {})

    stub_request(:get, "https://api.unsplash.com/search/photos?query=peru&client_id=#{ENV['unsplash_access_key']}")
    .to_return(status: 200, body: File.read('./spec/fixtures/peru_images.json'), headers: {})
    country = 'peru'
    learning_resource = LearningResourceFacade.get_learning_resources(country)

    expect(learning_resource).to be_an_instance_of(LearningResource)
  end
end