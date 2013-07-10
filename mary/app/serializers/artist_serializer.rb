class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :links, :albums

  has_many :albums, serializer: LinksSerializer
  has_many :genres, serializer: LinksSerializer

  def links
    [{rel: :self, href: api_artist_url(object)}]
  end
end
