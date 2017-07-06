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

ActiveRecord::Schema.define(version: 20170706062840) do

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "quantity",     default: 1
    t.integer  "color_id"
    t.integer  "dimension_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string   "name"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "dimensions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "color_id"
    t.integer  "dimension_id"
    t.decimal  "cost",         precision: 8, scale: 2
    t.integer  "quantity"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "inventory_transactions", force: :cascade do |t|
    t.integer  "inventory_id"
    t.decimal  "original_cost",     precision: 8, scale: 2
    t.integer  "original_quantity"
    t.decimal  "change_cost",       precision: 8, scale: 2
    t.integer  "change_quantity"
    t.decimal  "final_cost",        precision: 8, scale: 2
    t.integer  "final_quantity"
    t.integer  "changed_type"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "source_id"
  end

  create_table "order_infos", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "billing_name"
    t.string   "billing_address"
    t.string   "shipping_name"
    t.string   "shipping_address"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "product_name"
    t.integer  "price"
    t.integer  "quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "color_name"
    t.string   "dimension_name"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "total",          default: 0
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "token"
    t.boolean  "is_paid",        default: false
    t.string   "payment_method"
    t.string   "aasm_state",     default: "order_placed"
    t.index ["aasm_state"], name: "index_orders_on_aasm_state"
    t.index ["token"], name: "index_orders_on_token"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_options", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "dimension_id"
    t.integer  "color_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "quantity"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "purchase_items", force: :cascade do |t|
    t.integer  "purchase_id"
    t.integer  "dimension_id"
    t.integer  "color_id"
    t.integer  "quantity"
    t.decimal  "currency_price", precision: 8, scale: 2
    t.decimal  "tw_price",       precision: 8, scale: 2
    t.decimal  "duty",           precision: 8, scale: 2
    t.decimal  "shipping_fee",   precision: 8, scale: 2
    t.decimal  "service_fee",    precision: 8, scale: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "product_id"
    t.decimal  "sub_total",      precision: 8, scale: 2
    t.decimal  "total",          precision: 8, scale: 2
  end

  create_table "purchases", force: :cascade do |t|
    t.decimal  "total_currency_price",        precision: 8, scale: 2
    t.integer  "total_tw_price"
    t.integer  "total_tw_duty"
    t.integer  "total_tw_service_fee"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.datetime "purchase_date"
    t.datetime "delivery_date"
    t.decimal  "currency_rate",               precision: 8, scale: 4
    t.decimal  "total_tw_shipping_fee",       precision: 8, scale: 2
    t.decimal  "total_currency_shipping_fee", precision: 8, scale: 2
    t.integer  "round_diff_money"
  end

  create_table "sale_items", force: :cascade do |t|
    t.integer  "sale_id"
    t.integer  "product_id"
    t.integer  "dimension_id"
    t.integer  "color_id"
    t.decimal  "cost"
    t.integer  "quantity"
    t.integer  "sale_price"
    t.integer  "shipping_fee",   default: 0
    t.integer  "service_fee",    default: 0
    t.integer  "credit_fee",     default: 0
    t.decimal  "profit"
    t.decimal  "profit_rate"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.decimal  "cost_sub_total"
    t.integer  "sale_sub_total"
  end

  create_table "sale_platforms", force: :cascade do |t|
    t.decimal  "service_rate"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sales", force: :cascade do |t|
    t.string   "order_number"
    t.string   "city_id"
    t.string   "district_id"
    t.string   "address"
    t.integer  "sale_platform_id"
    t.integer  "ship_type_id"
    t.integer  "total_cost"
    t.integer  "total_shipping_fee"
    t.integer  "total_service_fee"
    t.integer  "total_profit"
    t.decimal  "total_profit_rate"
    t.datetime "sale_date"
    t.datetime "shipping_date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "total_sale"
    t.string   "shipping_number"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_admin",               default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
