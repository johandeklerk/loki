FactoryGirl.define do

  factory :album_publisher, :class => Publisher do
    name { "#{Faker::Name.name}#{rand(100)}" }
  end

  factory :album_artist, :class => Artist do
    name { Faker::Name.name }
  end

  factory :album_artist_1, :class => Artist do
    name { Faker::Name.first_name }
  end

  factory :album_track_1, parent: :track do
    title { Faker::Name.title }
  end

  factory :album_track_2, parent: :track do
    title { Faker::Name.name }
  end

  factory :album_track_3, parent: :track do
    title { Faker::Name.first_name }
  end

  factory :album_genre, :class => Genre do
    name { Faker::Name.name }
  end

  factory :album do
    title { Faker::Name.title }
    isbn '9780672317248'
    published_date Chronic.parse('16 September 2001')
    publisher { create(:album_publisher) }
    artists { [create(:album_artist)] }
    genres { [create(:album_genre)] }
    tracks { [create(:album_track_1), create(:album_track_2), create(:album_track_3)] }
  end

  factory :album_1, parent: :album do
    artists { [create(:album_artist_1)] }
  end

  factory :invalid_album, parent: :album do
    title nil
  end

  factory :title_invalid_album, parent: :album do
    title nil
  end

  factory :publisher_invalid_album, parent: :album do
    publisher nil
  end

  factory :genres_invalid_album, parent: :album do
    genres nil
  end

  factory :tracks_invalid_album, parent: :album do
    tracks nil
  end

  factory :artists_invalid_album, parent: :album do
    artists nil
  end

  factory :published_date_invalid_album, parent: :album do
    published_date nil
  end

  factory :title_min_length_invalid_album, parent: :album do
    title ''
  end

  factory :title_max_length_invalid_album, parent: :album do
    title 'aslkdj alkdjaslkd jaslk djlaskjd lkasjdasldfhjehf asdjhfksjdhfksjdfhsdk fhsd fsdf hjfh skjsdhf kjsdhf uioqyfraqwe ohf askdjfh'
  end

  factory :publisher_max_length_invalid_album, parent: :album do
    title 'aslkdj alkdjaslkd jaslk djlaskjd lkasjdasldfhjehf asdjhfksjdhfksjdfhsdk fhsd fsdf hjfh skjsdhf kjsdhf uioqyfraqwe ohf askdjfh'
  end

  factory :isbn_invalid_album, parent: :album do
    isbn nil
  end

  factory :isbn_format_invalid_album, parent: :album do
    isbn 'AHJKGSD-/3423'
  end

  factory :isbn_min_length_invalid_album, parent: :album do
    isbn '234-X'
  end

  factory :isbn_max_length_invalid_album, parent: :album do
    isbn '203498904-1234235-2345-235-235235-23-5-23-523'
  end
end