class LearningResourceFacade

  def self.get_learning_resources(country)
    video_data = YoutubeService.get_video(country)
    if video_data.nil?
      video = {}
    else
      video = Video.new(video_data)
    end

    images_data = UnsplashService.get_images(country)
    if images_data[:results].empty? 
      images = []
    else
      images = images_data[:results].map do |image_data|
        Image.new(image_data)
      end
    end
    
    LearningResource.new(country, video, images)
  end
end