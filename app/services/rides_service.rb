class RidesService
  class << self
    def match_rides(z1, z2)
     response = conn.get("/#{z1}/2") do |request|
      end
      require 'pry'; binding.pry
    end

    def conn
      Faraday.new(url: 'https://protected-thicket-75507.herokuapp.com')
    end
  end
end
