# Model for Genres
class Genre
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields are all aliased to save disk space
  # We don't need attr_accessible in Rails 4 due to strong_parameters
  field :name, type: String

  validates_presence_of :name, message: 'required field'
  validates_length_of :name, :within => 1..100, message: 'field length must be within 1 to 100'
  validates_uniqueness_of :name

  # Relationships
  has_and_belongs_to_many :artists, index: true
  has_and_belongs_to_many :albums, index: true

  index({name: 1}, {unique: true})

  def cached
    Rails.cache.fetch(self, expires_in: 2.minutes) { self }
  end

  def cached_albums
    Rails.cache.fetch([self, 'albums'], expires_in: 2.minutes) { albums.to_a }
  end

  def cached_artists
    Rails.cache.fetch([self, 'artists'], expires_in: 2.minutes) { artists.to_a }
  end
end
