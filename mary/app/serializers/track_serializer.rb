class TrackSerializer < ActiveModel::Serializer
  attributes :id, :title, :length, :links

  has_many :albums, serializer: LinksSerializer
  has_many :artists, serializer: LinksSerializer
  has_many :genres, serializer: LinksSerializer

  def links
    [{rel: :self, href: api_track_url(object)}]
  end
end
