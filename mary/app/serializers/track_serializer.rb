class TrackSerializer < ActiveModel::Serializer
  attributes :id, :title, :length, :links

  #has_many :albums
  #has_many :artists
  #has_many :genres

  def links
    [{rel: :self, href: api_track_url(object)},
     {rel: :albums, href: object.albums.map { |album| {href: api_album_url(album)} }},
     {rel: :artists, href: object.artists.map { |artist| {href: api_artist_url(artist)} }},
     {rel: :genres, href: object.genres.map { |genre| {href: api_genre_url(genre)} }}]
  end
end
