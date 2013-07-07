class Publisher
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  validates_presence_of :name, :message => 'required field'
  validates_length_of :name, :within => 1..100, message: 'field length must be within 1 to 100'

  has_many :albums
  has_and_belongs_to_many :artists

  index({name: 1}, {unique: true})
end
