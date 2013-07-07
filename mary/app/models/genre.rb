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
end
