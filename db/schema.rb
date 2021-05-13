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

ActiveRecord::Schema.define(version: 2021_05_13_135105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivedays", force: :cascade do |t|
    t.bigint "drive_id"
    t.string "day_of_week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drive_id"], name: "index_drivedays_on_drive_id"
  end

  create_table "drives", force: :cascade do |t|
    t.bigint "user_id"
    t.string "origin"
    t.string "destination"
    t.string "departure_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_drives_on_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friends_on_friend_id"
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "about_me"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "make"
    t.string "model"
    t.string "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "drivedays", "drives", column: "drive_id"
  add_foreign_key "drives", "users"
  add_foreign_key "friends", "users"
  add_foreign_key "friends", "users", column: "friend_id"
  add_foreign_key "vehicles", "users"
end
