module AlbumRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :title
  property :isbn
  property :published_date
  property :created_at
  property :updated_at

  link :self do
    api_album_url self
  end

  link :publisher do
    api_publisher_url publisher
  end

  link :artists do
    artists.collect do |artist|
      api_artist_url artist
    end
  end

  link :tracks do
    tracks.collect do |track|
      api_track_url track
    end
  end

  link :genres do
    genres.collect do |genre|
      api_genre_url genre
    end
  end
end