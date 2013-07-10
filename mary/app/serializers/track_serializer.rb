class TrackSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :albums, serializer: LinksSerializer
  has_many :artists, serializer: LinksSerializer
  has_many :genres, serializer: LinksSerializer
end
