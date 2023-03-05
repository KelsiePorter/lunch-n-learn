class Country 
  attr_reader :country_name

  def initialize(country)
    @country_name = country[:common].downcase
  end
end