module MediaGallery
  class ImageVersion < ApplicationRecord
    belongs_to :ownable, polymorphic: true

    mount_base64_uploader :image, ImageUploader
  end
end
