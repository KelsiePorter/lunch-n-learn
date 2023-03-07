class Api::V1::UsersController < ApplicationController 

  def create 
    # can I do: user = User.new(permitted_params).generate_api_key ??
    user = User.new(permitted_params)
    user.generate_api_key

    if user.save 
      render json: UserSerializer.new(user), status: :created
    else
      render json: { errors: user.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:name, :email)
  end
end