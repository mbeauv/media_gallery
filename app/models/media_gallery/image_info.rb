module MediaGallery
  class ImageInfo < ApplicationRecord
    belongs_to :gallery

    has_one :image_version, as: :ownable, dependent: :destroy

    validates :label, length: { maximum: 256 }, presence: true
    validates :description, length: { maximum: 1024 }

  end
end
