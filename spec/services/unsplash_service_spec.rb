require 'rails_helper' 

RSpec.describe UnsplashService do 
  it 'returns 10 images based on the query that is passed in' do 
    stub_request(:get, "https://api.unsplash.com/search/photos?query=peru&client_id=#{ENV['unsplash_access_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/peru_images.json'), headers: {})

      country = 'peru'
      response = UnsplashService.get_images(country)

      expect(response).to be_a Hash
      expect(response).to have_key(:results)
      expect(response[:results]).to be_an Array
      expect(response[:results].count).to eq(10)
      expect(response[:results][0]).to have_key(:urls)
      expect(response[:results][0][:urls]).to be_a Hash
      expect(response[:results][0][:urls]).to have_key(:raw)
      expect(response[:results][0][:urls][:raw]).to be_a String
      expect(response[:results][0]).to have_key(:alt_description)
      expect(response[:results][0][:alt_description]).to be_a String
  end

  it 'returns and empty array if you images are found' do 
    stub_request(:get, "https://api.unsplash.com/search/photos?query=&client_id=#{ENV['unsplash_access_key']}")
    .to_return(status: 200, body: File.read('./spec/fixtures/no_peru_images.json'), headers: {})

    country = ''
    response = UnsplashService.get_images(country)
    
    expect(response).to be_a Hash
    expect(response).to have_key(:results)
    expect(response[:results]).to be_an Array
    expect(response[:results].count).to eq(0)
  end
end