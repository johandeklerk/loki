class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :cover, :isbn, :published_date, :links

  #has_one :publisher
  #has_many :artists
  #has_many :tracks
  #has_many :genres

  def links
    [{rel: :self, href: api_album_url(object)},
     {rel: :publisher, href: api_publisher_url(object.publisher)},
     {rel: :artists, href: object.artists.map { |artist| {href: api_artist_url(artist)} }},
     {rel: :tracks, href: object.tracks.map { |track| {href: api_track_url(track)} }},
     {rel: :genres, href: object.genres.map { |genre| {href: api_genre_url(genre)} }}]
  end
end
