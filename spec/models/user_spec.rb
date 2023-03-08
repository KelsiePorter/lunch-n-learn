require 'rails_helper'

RSpec.describe User do 
  describe 'validations' do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :api_key }

    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :api_key }
  end

  describe 'relationships' do 
    it { should have_many :favorites }
  end
  
  describe 'create api key' do 
    it 'generates random 27 character string for users api key' do

      new_user = User.new(name: 'River', email: 'river@example.com')

      expect(new_user.api_key).to be nil
      
      new_user.generate_api_key

      expect(new_user.api_key).to be_a String
    end 
  end
end