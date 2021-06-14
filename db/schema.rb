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

ActiveRecord::Schema.define(version: 2020_12_10_095019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "date"
    t.time "start_time"
    t.time "end_time"
    t.text "comment"
    t.string "status"
    t.bigint "helper_id", null: false
    t.bigint "senior_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "booking_step"
    t.integer "hour_number"
    t.index ["helper_id"], name: "index_bookings_on_helper_id"
    t.index ["senior_id"], name: "index_bookings_on_senior_id"
  end

  create_table "calendar_events", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "event"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_calendar_events_on_user_id"
  end

  create_table "diplomas", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_diplomas_on_user_id"
  end

  create_table "favoris", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_favoris_on_booking_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "note"
    t.text "content"
    t.bigint "booking_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_reviews_on_booking_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "year"
    t.integer "month"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "occurrences", default: [], array: true
    t.string "sch_type"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.bigint "booking_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_tasks_on_booking_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "mobile_number"
    t.string "role"
    t.string "pathology"
    t.string "handicap"
    t.boolean "car"
    t.date "activity_start_date"
    t.text "description"
    t.float "price"
    t.float "latitude"
    t.float "longitude"
    t.string "photo", default: "https://res.cloudinary.com/dh78qytaz/image/upload/d_default_photo/v1607589287/default_photo.png"
    t.string "access_token"
    t.string "refresh_token"
    t.string "expires_at"
    t.string "address2"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "users", column: "helper_id"
  add_foreign_key "bookings", "users", column: "senior_id"
  add_foreign_key "calendar_events", "users"
  add_foreign_key "diplomas", "users"
  add_foreign_key "favoris", "bookings"
  add_foreign_key "reviews", "bookings"
  add_foreign_key "schedules", "users"
  add_foreign_key "tasks", "bookings"
end
