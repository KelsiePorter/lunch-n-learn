class LearningResourceFacade

  def self.get_learning_resources(country)
    video_data = YoutubeService.get_video(country)
    video = Video.new(video_data)

    images_data = UnsplashService.get_images(country)
    images = images_data[:results].map do |image_data|
      Image.new(image_data)
    end

    LearningResource.new(country, video, images)
  end
end