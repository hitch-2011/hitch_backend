class AddressValidatorService
  class << self
    def validate_address(place_info)
      conn.('/api/v1/validate_address') do |request|
        require 'pry'; binding.pry
        request.params[''] = place_info
      end.body
    end

    def conn
      Faraday.new(url: 'https://hitch-microservice-smarty-st.herokuapp.com/')
    end
  end
end

