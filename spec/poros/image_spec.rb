require 'rails_helper' 

RSpec.describe Video do 
  it 'exists and has attributes' do 
    images_data = File.read('./spec/fixtures/single_peru_image_data.json')
    parsed_image_data = JSON.parse(images_data, symbolize_names: true)

    image = Image.new(parsed_image_data)

    expect(image).to be_an_instance_of(Image)
    expect(image.alt_tag).to eq("mountain with clouds")
    expect(image.url).to eq("https://images.unsplash.com/photo-1526392060635-9d6019884377?ixid=Mnw0MTg4ODV8MHwxfHNlYXJjaHwxfHxwZXJ1fGVufDB8fHx8MTY3ODA2NTk5Mw&ixlib=rb-4.0.3")
  end
end
