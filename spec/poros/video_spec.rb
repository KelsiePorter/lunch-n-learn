require 'rails_helper' 

RSpec.describe Video do 
  it 'exists and has attributes' do 
    video_data = File.read('./spec/fixtures/peru_video_data.json')
    parsed_video_data = JSON.parse(video_data, symbolize_names: true)

    video = Video.new(parsed_video_data[:items][0])

    expect(video).to be_an_instance_of(Video)
    expect(video.title).to eq("A Super Quick History of Peru")
    expect(video.youtube_video_id).to eq("nJf62pMnjHA")
  end
end
