FactoryGirl.define do

  factory :track do
    title { Faker::Name.title }
    length 'one minute and 40 seconds'
  end

  factory :track_1, parent: :track do
    length 'one minute and 40 seconds'
  end

  factory :track_2, parent: :track do
    length '27 minutes and 12 seconds'
  end

  factory :invalid_track, parent: :track do
    title nil
  end

  factory :invalid_title_track, parent: :invalid_track

  factory :invalid_length_track, parent: :track do
    length nil
  end

  factory :invalid_length_track_1, parent: :track do
    length 'not a valid length'
  end
end