# Model for Albums
class Album
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields are all aliased to save disk space
  # We don't need attr_accessible in Rails 4 due to strong_parameters
  field :title, type: String
  field :cover, type: Moped::BSON::Binary
  field :isbn, type: String
  field :published_date, type: DateTime

  #attr_accessor :id, :title, :cover, :isbn, :publisher, :published_date, :artists, :tracks, :genres

  validates_presence_of :title, :isbn, :publisher, :published_date, :artists, :tracks, :genres, message: 'required field'
  validates_format_of :isbn, with: /^(97(8|9))?\d{9}(\d|X)$/, :multiline => true, message: 'only valid ISBN format'
  validates_length_of :isbn, within: 10..13, message: 'field length must be within 10 to 13'
  validates_length_of :title, :publisher, :within => 1..100, message: 'field length must be within 1 to 100'


  # Relationships
  belongs_to :publisher, index: true
  has_and_belongs_to_many :artists, index: true
  has_and_belongs_to_many :tracks, index: true
  has_and_belongs_to_many :genres, index: true

  index({title: 1}, {unique: true})
  index({isbn: 1}, {unique: true})
end