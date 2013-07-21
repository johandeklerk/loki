class PublisherSerializer < ActiveModel::Serializer
  attributes :name, :links

  #has_many :artists
  #has_many :albums

  def links
    [{rel: :self, href: api_publisher_url(object.cached)},
     {rel: :artists, href: object.cached_artists.map { |artist| {href: api_artist_url(artist)} }},
     {rel: :albums, href: object.cached_albums.map { |album| {href: api_album_url(album)} }}]
  end
end
