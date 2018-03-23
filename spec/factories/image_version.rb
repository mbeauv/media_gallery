# This will guess the User class
FactoryBot.define do
  factory :image_version, class: MediaGallery::ImageVersion do
    association :ownable, factory: :user
  end
end
