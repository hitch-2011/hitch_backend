class AddressValidatorService
  class << self
    def validate_address(place_info)
      response = conn.('/api/v1/validate_address') do |request|
      end
    end

    def conn
      Faraday.new(url: 'https://hitch-microservice-smarty-st.herokuapp.com/')
    end
  end
end
