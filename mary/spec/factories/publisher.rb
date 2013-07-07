FactoryGirl.define do

  factory :publisher do
    name { Faker::Name.name }
  end

  factory :invalid_publisher, parent: :publisher do
    name nil
  end

  factory :invalid_name_publisher, parent: :invalid_publisher
end