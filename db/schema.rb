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

ActiveRecord::Schema.define(version: 20180329084300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "unit_id"
    t.string "platform"
    t.string "status"
    t.string "guest"
    t.datetime "check_in"
    t.datetime "check_out"
    t.float "rate", default: 0.0
    t.integer "no_of_nights", default: 1
    t.float "extra_fee", default: 0.0
    t.float "cleaning_fee", default: 0.0
    t.float "platform_service_fee", default: 0.0
    t.float "total", default: 0.0
    t.float "total_without_cleaning", default: 0.0
    t.float "average_rate", default: 0.0
    t.text "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "category_id"
    t.integer "unit_id"
    t.date "date"
    t.string "description"
    t.float "amount", default: 0.0
    t.float "discount", default: 0.0
    t.integer "no_of_items", default: 1
    t.float "total", default: 0.0
    t.text "remark"
    t.boolean "claimed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_expenses_on_category_id"
  end

  create_table "units", force: :cascade do |t|
    t.integer "owner_id"
    t.string "unit_no"
    t.string "street1"
    t.string "street2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.integer "room_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "calendar_label", limit: 7
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "mobile_no"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_type"
    t.boolean "admin", default: false
    t.datetime "welcomed_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
