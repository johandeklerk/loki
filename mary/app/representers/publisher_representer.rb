module PublisherRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :name
  property :created_at
  property :updated_at

  link :self do
    api_publisher_url self
  end

  link :albums do
    albums.collect do |album|
      api_album_url album
    end
  end

  link :artists do
    artists.collect do |artist|
      api_artist_url artist
    end
  end
end