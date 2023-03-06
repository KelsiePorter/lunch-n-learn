require 'rails_helper'

RSpec.describe YoutubeService do 
  it 'returns a video resource based on a specified keyword query' do
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api_key']}&maxResults=1&part=snippet&q=peru")
      .to_return(status: 200, body: File.read('./spec/fixtures/peru_video_resource.json'), headers: {})
    country = 'peru'
    response = YoutubeService.get_video(country)

    expect(response).to be_a Hash
    expect(response).to have_key(:id)
    expect(response[:id]).to be_a Hash
    expect(response[:id]).to have_key(:videoId)
    expect(response[:id][:videoId]).to be_a String
    expect(response).to have_key(:snippet)
    expect(response[:snippet]).to be_a Hash
    expect(response[:snippet]).to have_key(:title)
    expect(response[:snippet][:title]).to be_a String
  end

  it 'returns an empty array if no videos are found' do 
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api_key']}&maxResults=1&part=snippet&q=gdfgxfh")
      .to_return(status: 200, body: File.read('./spec/fixtures/no_matching_video_resource.json'), headers: {})
    country = 'gdfgxfh'
    response = YoutubeService.get_video(country)

    expect(response).to be(nil)
  end
end