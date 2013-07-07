module ArtistRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :name
  property :created_at
  property :updated_at

  link :self do
    api_artist_url self
  end

  link :albums do
    albums.collect do |album|
      api_album_url album
    end
  end

  link :genres do
    genres.collect do |genre|
      api_genre_url genre
    end
  end
end