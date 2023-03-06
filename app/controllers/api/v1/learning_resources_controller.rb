class Api::V1::LearningResourcesController < ApplicationController
  def index 
    result = LearningResourceFacade.get_learning_resources(params[:country])
    render json: LearningResourceSerializer.new(result)
  end
end