# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150621154325) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "customers", force: :cascade do |t|
    t.text     "firstname"
    t.text     "lastname"
    t.text     "etsy_username"
    t.text     "email"
    t.text     "source"
    t.text     "ship_name"
    t.text     "ship_address1"
    t.text     "ship_address2"
    t.text     "ship_city"
    t.text     "ship_state"
    t.text     "ship_zipcode"
    t.text     "ship_country"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.date     "sale_date"
    t.text     "item_name"
    t.text     "buyer"
    t.integer  "quantity"
    t.float    "price"
    t.text     "coupon_code"
    t.text     "coupon_details"
    t.float    "coupon_discount"
    t.float    "order_shipping"
    t.float    "order_sales_tax"
    t.float    "item_total"
    t.string   "currency"
    t.string   "transaction_id"
    t.string   "listing_id"
    t.date     "date_paid"
    t.date     "date_shipped"
    t.text     "ship_name"
    t.text     "ship_address1"
    t.text     "ship_address2"
    t.text     "ship_city"
    t.text     "ship_state"
    t.text     "ship_zipcode"
    t.text     "ship_country"
    t.string   "order_id"
    t.text     "variations"
    t.string   "order_type"
    t.string   "listings_type"
    t.string   "payment_type"
    t.text     "inperson_discount"
    t.text     "inperson_location"
    t.float    "etsy_fee"
    t.text     "notes"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "orders", force: :cascade do |t|
    t.date     "sale_date"
    t.string   "order_id"
    t.string   "buyer_user_id"
    t.string   "full_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "number_of_items"
    t.string   "payment_method"
    t.date     "date_shipped"
    t.text     "ship_address1"
    t.text     "ship_address2"
    t.text     "ship_city"
    t.text     "ship_state"
    t.text     "ship_zipcode"
    t.text     "ship_country"
    t.string   "currency"
    t.float    "order_value"
    t.text     "coupon_code"
    t.text     "coupon_details"
    t.float    "shipping"
    t.float    "sales_tax"
    t.float    "order_total"
    t.text     "status"
    t.float    "card_processing_fees"
    t.float    "order_net"
    t.float    "adjusted_order_total"
    t.float    "adjusted_card_processing_fees"
    t.float    "adjusted_net_order_amount"
    t.text     "buyer"
    t.string   "order_type"
    t.string   "payment_type"
    t.text     "inperson_discount"
    t.text     "inperson_location"
    t.string   "order_source"
    t.float    "packaging_cost"
    t.float    "shipping_cost"
    t.text     "notes"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "products", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.text     "file"
    t.string   "product_type"
    t.text     "occasion"
    t.text     "color"
    t.text     "size"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
