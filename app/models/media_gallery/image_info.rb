module MediaGallery
  class ImageInfo < ApplicationRecord
    belongs_to :gallery

    mount_uploader :image, ImageUploader

    validates :label, length: { maximum: 256 }, presence: true
    validates :description, length: { maximum: 1024 }

  end
end
