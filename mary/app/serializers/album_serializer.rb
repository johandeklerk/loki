class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :cover, :isbn, :published_date, :links

  has_one :publisher, serializer: LinksSerializer
  has_many :artists, serializer: LinksSerializer
  has_many :tracks, serializer: LinksSerializer
  has_many :genres, serializer: LinksSerializer

  def links
    [{rel: :self, href: api_album_url(object)}]
  end
end
