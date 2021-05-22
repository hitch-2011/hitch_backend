class MapquestService
  class << self
    def find_drivable_route(origin, destination)
      response = conn.get('/find_drivable_route') do |req|
        req.params[:address1] = origin.gsub(" ", "+")
        req.params[:address2] = destination.gsub(" ", "+")
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: 'https://serene-mountain-58748.herokuapp.com')
    end
  end
end
