class User < ApplicationRecord 
  has_many :favorites,
            primary_key: :user_api_key

  validates_presence_of :name, :email, :api_key
  validates :email, uniqueness: true
  validates :api_key, uniqueness: true

  def generate_api_key
    self.api_key = SecureRandom.hex(27)
  end
end