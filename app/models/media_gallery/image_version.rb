module MediaGallery
  class ImageVersion < ApplicationRecord
    belongs_to :ownable, polymorphic: true

    mount_uploader :image, ImageUploader
  end
end
