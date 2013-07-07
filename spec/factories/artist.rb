require 'faker'

FactoryGirl.define do

  factory :artist do
    name Faker::Name.name
    description 'asdasdasdasdasdaqsdasda'
  end
end