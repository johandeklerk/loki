module TrackRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :title
  property :length
  property :created_at
  property :updated_at

  link :self do
    api_track_url self
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

  link :genres do
    genres.collect do |genre|
      api_genre_url genre
    end
  end
end