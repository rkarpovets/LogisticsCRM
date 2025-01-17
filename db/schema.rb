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

ActiveRecord::Schema[8.0].define(version: 2024_12_29_034957) do
  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "contact_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "contact_number"
    t.integer "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_drivers_on_vehicle_id"
  end

  create_table "order_requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "delivery_address"
    t.integer "product_id", null: false
    t.integer "quantity"
    t.string "status"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_order_requests_on_product_id"
    t.index ["user_id"], name: "index_order_requests_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "tracking_number"
    t.integer "customer_id"
    t.integer "product_id"
    t.integer "driver_id"
    t.integer "quantity"
    t.decimal "total_price", precision: 10, scale: 2
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["driver_id"], name: "index_orders_on_driver_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "available_quantity"
    t.decimal "unit_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.string "first_name"
    t.string "last_name"
    t.date "birth_date"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.integer "year"
    t.string "vehicle_identification_number"
    t.string "license_plate_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "drivers", "vehicles"
  add_foreign_key "order_requests", "products"
  add_foreign_key "order_requests", "users"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "drivers"
  add_foreign_key "orders", "products"
end
