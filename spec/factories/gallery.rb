# This will guess the User class
FactoryBot.define do
  factory :gallery, class: MediaGallery::Gallery do
    sequence(:name) { |n| "user#{n}_gallery" }
    description "a test gallery"
  end
end
