class RidesService
  class << self

    def match_origin(origin)
     response = conn.get("distance/#{origin}/2") do |request|
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    def match_destination(destination)
      response = conn.get("distance/#{destination}/2") do |request|
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: 'https://protected-thicket-75507.herokuapp.com')
    end
  end
end

