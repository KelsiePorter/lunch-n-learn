class Favorite < ApplicationRecord
  belongs_to :user, foreign_key: 'user_api_key', primary_key: 'api_key'

  validates_presence_of :country, :recipe_link, :recipe_title
end