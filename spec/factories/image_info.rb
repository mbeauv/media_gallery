# This will guess the User class
FactoryBot.define do
  factory :image_info, class: MediaGallery::ImageInfo do
    sequence(:name) { |n| "info#{n}" }
    description "an image info description"
    created_at DateTime.parse("2018-03-31T10:36:57.813Z")
    updated_at DateTime.parse("2018-03-31T11:36:57.813Z")
    association :image_version, factory: :image_version
  end
end
