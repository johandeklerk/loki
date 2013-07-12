  class Artist < Hashie::Dash
  include HTTParty
  base_uri 'localhost:3000'
  headers 'Accept' => 'application/vnd.mary+json; version=1', 'Content-Type' => 'application/json'

  property :id
  property :name
  property :albums
  property :genres
  property :links

  class << self
    def all
      response = self.get('/artists')
      JSON.parse(response.body).collect do |artist|
        self.new(artist)
      end
    end

    def find(id)
      response = self.get("/artists#{id}")
      self.new(JSON.parse(response.body))
    end
  end

  def albums
    self[:albums].collect do |links|
      links.each do |_, link|
        response = Artist.get(link[0]['href'])
        return JSON.parse(response.body)
      end
    end
  end
end