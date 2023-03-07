require 'rails_helper' 

RSpec.describe LearningResource do 
  it 'exists and has attributes' do 
    country = 'peru'
    video = JSON.parse(File.read('./spec/fixtures/peru_video_data.json'), symbolize_names: true)
    images = JSON.parse(File.read('./spec/fixtures/peru_images.json'), symbolize_names: true)

    learning_resource = LearningResource.new(country, video, images)

    expect(learning_resource.country).to eq('peru')
    expect(learning_resource.video).to be_a Hash
    expect(learning_resource.images).to be_a Hash
  end
end