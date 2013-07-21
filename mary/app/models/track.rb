class Track
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :length, type: Numeric

  validates_presence_of :title, message: 'required field'
  validates_length_of :title, :within => 1..100, message: 'field length must be within 1 to 100'
  validates_each :length do |record, attr, value|
    record.errors.add attr, 'invalid' unless ChronicDuration.parse(value.to_s)
  end

  has_and_belongs_to_many :albums, index: true
  has_and_belongs_to_many :artists, index: true
  has_and_belongs_to_many :genres, index: true

  index({title: 1})

  def cached
    Rails.cache.fetch(self, expires_in: 2.minutes) { self }
  end

  def cached_albums
    Rails.cache.fetch([self, 'albums'], expires_in: 2.minutes) { albums.to_a }
  end

  def cached_artists
    Rails.cache.fetch([self, 'artists'], expires_in: 2.minutes) { artists.to_a }
  end

  def cached_genres
    Rails.cache.fetch([self, 'genres'], expires_in: 2.minutes) { genres.to_a }
  end
end
