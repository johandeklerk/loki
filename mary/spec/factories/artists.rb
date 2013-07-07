FactoryGirl.define do

  factory :artist do
    name { Faker::Name.prefix }
  end

  factory :invalid_artist, parent: :artist do
    name nil
  end

  factory :invalid_name_artist, parent: :invalid_artist
end