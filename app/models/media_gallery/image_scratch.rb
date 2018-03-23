module MediaGallery
  class ImageScratch < ApplicationRecord
    belongs_to :ownable, polymorphic: true, autosave: true
    belongs_to :image_version, optional: true, autosave: true
  end
end
