# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_05_200355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "link_uses", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.bigint "link_id", null: false
    t.text "user_agent"
    t.text "identity"
    t.index ["link_id"], name: "index_link_uses_on_link_id"
  end

  create_table "links", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "url", null: false
    t.text "description"
    t.text "slug", null: false
    t.datetime "first_used_at"
    t.datetime "last_used_at"
    t.bigint "uses_count", default: 0
    t.index ["slug"], name: "index_links_on_slug", unique: true
    t.index ["url"], name: "index_links_on_url"
  end

  add_foreign_key "link_uses", "links", on_delete: :cascade
end
