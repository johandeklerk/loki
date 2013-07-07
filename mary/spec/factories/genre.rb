FactoryGirl.define do

  factory :genre do
    name { Faker::Name.last_name }
  end

  factory :invalid_genre, parent: :genre do
    name nil
  end

  factory :invalid_name_genre, parent: :invalid_genre
end