# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180327140541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "media_gallery_galleries", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", limit: 1024
    t.string "ownable_type"
    t.bigint "ownable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ownable_type", "ownable_id"], name: "index_media_gallery_galleries_on_ownable_type_and_ownable_id"
  end

  create_table "media_gallery_image_infos", force: :cascade do |t|
    t.string "description", limit: 1024
    t.bigint "gallery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["gallery_id"], name: "index_media_gallery_image_infos_on_gallery_id"
  end

  create_table "media_gallery_image_scratches", force: :cascade do |t|
    t.string "ownable_type"
    t.bigint "ownable_id"
    t.bigint "image_version_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_version_id"], name: "index_media_gallery_image_scratches_on_image_version_id"
    t.index ["ownable_type", "ownable_id"], name: "image_scratch_ownable_index"
  end

  create_table "media_gallery_image_versions", force: :cascade do |t|
    t.string "ownable_type"
    t.bigint "ownable_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ownable_type", "ownable_id"], name: "image_version_ownable_index"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "token", null: false
    t.boolean "admin", null: false
    t.boolean "disabled", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "media_gallery_image_scratches", "media_gallery_image_versions", column: "image_version_id"
end
