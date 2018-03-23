class CreateMediaGalleryImageScratches < ActiveRecord::Migration[5.1]
  def change
    create_table :media_gallery_image_scratches do |t|
      t.references :ownable, polymorphic: true, index: { name: 'image_scratch_ownable_index' }
      t.belongs_to :image_version, foreign_key: { to_table: :media_gallery_image_versions }
      t.timestamps
    end
  end
end
