class GenreSerializer < ActiveModel::Serializer
  attributes :name, :links

  #has_many :artists
  #has_many :albums

  def links
    [{rel: :self, href: api_genre_url(object)},
     {rel: :artists, href: object.artists.map { |artist| {href: api_artist_url(artist)} }},
     {rel: :albums, href: object.albums.map { |album| {href: api_album_url(album)} }}]
  end
end
