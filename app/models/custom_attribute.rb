class CustomAttribute < ActiveRecord::Base
  belongs_to :attributable, :polymorphic => true
end