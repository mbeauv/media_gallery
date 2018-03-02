module MediaGallery
  class Gallery < ApplicationRecord
    belongs_to :ownable, polymorphic: true
    has_many :image_infos, dependent: :destroy

    validates_presence_of :name
    validates :description, length: { maximum: 1024 }
    validates_uniqueness_of :name, scope: :ownable, message: 'Gallery with this name already exists.'
  end
end
