FactoryGirl.define do
  factory :survey do
    sequence(:name) { |n| "name_#{n}" }
    description "MyText"
    published :false

  end
end