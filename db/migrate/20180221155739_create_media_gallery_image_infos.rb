class CreateMediaGalleryImageInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :media_gallery_image_infos do |t|
      t.string :label, null: false
      t.string :description, limit: 1024
      t.string :image
      t.references :gallery, index: true
      t.timestamps
    end
  end
end
