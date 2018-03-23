# This will guess the User class
FactoryBot.define do
  factory :image_scratch, class: MediaGallery::ImageScratch do
    association :ownable, factory: :user
    association :image_version, factory: :image_version
  end
end
