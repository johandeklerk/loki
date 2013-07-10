class LinksSerializer < ActiveModel::Serializer
  attributes :links

  def links
    [{rel: :self, href: send("api_#{self.object.class.to_s.downcase}_url", object)}]
  end
end
