# This will guess the User class
FactoryBot.define do
  factory :image_info, class: MediaGallery::ImageInfo do
    sequence(:name) { |n| "info#{n}" }
    description "an image info description"
    association :image_version, factory: :image_version
  end
end
