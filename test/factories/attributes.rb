# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attribute do
    name "MyString"
    attributable_id 1
    attributable_type 1
  end
end
