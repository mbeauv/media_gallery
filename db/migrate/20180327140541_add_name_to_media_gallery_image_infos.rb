class AddNameToMediaGalleryImageInfos < ActiveRecord::Migration[5.1]

  class MediaGallery::ImageInfo < ActiveRecord::Base
  end

  def self.up
    add_column :media_gallery_image_infos, :name, :string
    remove_column :media_gallery_image_infos, :label
    MediaGallery::ImageInfo.find_each do |info|
      info.name = "name_#{info.id}"
      info.save!
    end
  end

  def self.down
    remove_column :media_gallery_image_infos, :name
    add_column :media_gallery_image_infos, :label, :string
  end
end
