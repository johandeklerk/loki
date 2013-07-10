class GenreSerializer < ActiveModel::Serializer
  attributes :name

  has_many :artists, serializer: LinksSerializer
  has_many :albums, serializer: LinksSerializer
end
