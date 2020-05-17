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

ActiveRecord::Schema.define(version: 2020_05_17_191244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.bigint "notification_id"
    t.jsonb "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mood_id"
    t.text "notes"
    t.bigint "user_id"
    t.index ["data"], name: "index_entries_on_data"
    t.index ["mood_id"], name: "index_entries_on_mood_id"
    t.index ["notification_id"], name: "index_entries_on_notification_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "moods", force: :cascade do |t|
    t.string "slug", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_moods_on_slug", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "subscription_id"
    t.jsonb "data", null: false
    t.datetime "dispatched_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nonce"
    t.index ["data"], name: "index_notifications_on_data"
    t.index ["subscription_id"], name: "index_notifications_on_subscription_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.jsonb "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_actions"
    t.index ["data"], name: "index_subscriptions_on_data", unique: true
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "entries", "moods"
  add_foreign_key "entries", "notifications"
  add_foreign_key "entries", "users"
  add_foreign_key "notifications", "subscriptions"
  add_foreign_key "subscriptions", "users"
end
