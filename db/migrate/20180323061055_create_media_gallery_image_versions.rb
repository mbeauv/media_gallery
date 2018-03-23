class CreateMediaGalleryImageVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :media_gallery_image_versions do |t|
      t.references :ownable, polymorphic: true, index: { name: 'image_version_ownable_index' }
      t.string :image
      t.timestamps
    end
    remove_column :media_gallery_image_infos, :image, :string
  end
end
