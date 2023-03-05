require 'rails_helper'

RSpec.describe YoutubeService do 
  it 'returns a video resource based on a specified keyword query' do
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api_key']}&maxResults=1&part=snippet&q=peru")
      .to_return(status: 200, body: File.read('./spec/fixtures/peru_video_resource.json'), headers: {})
    country = 'peru'
    response = YoutubeService.get_video(country)

    expect(response).to be_a Hash
    expect(response).to have_key(:items)
    expect(response[:items]).to be_an Array
    expect(response[:items].count).to eq(1)
    expect(response[:items][0]).to have_key(:id)
    expect(response[:items][0][:id]).to be_a Hash
    expect(response[:items][0][:id]).to have_key(:videoId)
    expect(response[:items][0][:id][:videoId]).to be_a String
    expect(response[:items][0]).to have_key(:snippet)
    expect(response[:items][0][:snippet]).to be_a Hash
    expect(response[:items][0][:snippet]).to have_key(:title)
    expect(response[:items][0][:snippet][:title]).to be_a String
  end
end