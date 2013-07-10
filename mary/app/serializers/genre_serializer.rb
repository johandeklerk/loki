class GenreSerializer < ActiveModel::Serializer
  attributes :name, :links

  has_many :artists, serializer: LinksSerializer
  has_many :albums, serializer: LinksSerializer

  def links
    [{rel: :self, href: api_genre_url(object)}]
  end
end
