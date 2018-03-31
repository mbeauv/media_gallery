# This will guess the User class
FactoryBot.define do
  factory :gallery, class: MediaGallery::Gallery do
    sequence(:name) { |n| "user#{n}_gallery" }
    description "a test gallery"
    created_at DateTime.parse("2018-03-31T10:36:57.813Z")
    updated_at DateTime.parse("2018-03-31T11:36:57.813Z")
    association :ownable, factory: :user
  end
end
