class CreateMediaGalleryGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :media_gallery_galleries do |t|
      t.string :name, null: false
      t.string :description, limit: 1024
      t.references :ownable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
