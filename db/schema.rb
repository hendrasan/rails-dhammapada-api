# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_15_165119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "chapters", force: :cascade do |t|
    t.integer "number"
    t.string "title"
    t.string "english_title"
    t.string "pali_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "verses_count"
  end

  create_table "verses", force: :cascade do |t|
    t.bigint "chapter_id", null: false
    t.integer "verse_number"
    t.text "text"
    t.text "english_text"
    t.text "pali_text"
    t.text "story_title"
    t.text "english_story_title"
    t.text "story"
    t.text "english_story"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_verses_on_chapter_id"
  end

  add_foreign_key "verses", "chapters"
end
