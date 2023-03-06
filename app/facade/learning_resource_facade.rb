class LearningResourceFacade

  def self.get_learning_resources(country)
    video = YoutubeService.get_video(country)
    images = UnsplashService.get_images(country)
    #serializer wil take a video arg and a img arg
  end
end