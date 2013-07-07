class Genre < ActiveRecord::Base
  has_many :custom_attributes, :as => :attributable
end
