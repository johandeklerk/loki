class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :links

  #has_many :albums
  #has_many :genres

  def links
    [{rel: :self, href: api_artist_url(object)},
     {rel: :albums, href: object.albums.map { |album| {href: api_album_url(album)} }},
     {rel: :genres, href: object.genres.map { |genre| {href: api_genre_url(genre)} }}]
  end
end
