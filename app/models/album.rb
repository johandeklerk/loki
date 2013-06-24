class Album < ActiveRecord::Base
  belongs_to :artist

  validates_presence_of :title, :release_date, :isbn, :artist_id
end