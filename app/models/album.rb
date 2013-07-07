class Album < ActiveRecord::Base
  belongs_to :artist

  has_many :custom_attributes, :as => :attributable

  validates_presence_of :title, :artist_id
end