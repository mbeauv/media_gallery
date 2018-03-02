# This will guess the User class
FactoryBot.define do
  factory :image_info, class: MediaGallery::ImageInfo do
    label "a test image"
    description "an image info description"
  end
end
