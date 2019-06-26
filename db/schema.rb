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

ActiveRecord::Schema.define(version: 2019_06_12_150752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "employee_id"
    t.time "end_time"
    t.time "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_attendances_on_employee_id"
  end

  create_table "boards", force: :cascade do |t|
    t.integer "number"
    t.integer "pos_x"
    t.integer "pos_y"
    t.integer "width"
    t.integer "height"
    t.bigint "company_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_boards_on_company_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_categories_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", limit: 100
    t.string "phone", limit: 100
    t.string "identification", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "names", limit: 100
    t.string "last_names", limit: 100
    t.string "address"
    t.string "state"
    t.string "city"
    t.string "identification"
    t.string "phone", limit: 100
    t.string "email", limit: 100
    t.date "birthday"
    t.date "start_date"
    t.binary "password"
    t.bigint "company_id"
    t.integer "role", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "product_id"
    t.bigint "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
    t.index ["product_id"], name: "index_menu_items_on_product_id"
  end

  create_table "menus", force: :cascade do |t|
    t.bigint "company_id"
    t.string "name"
    t.bigint "category_id"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_menus_on_category_id"
    t.index ["company_id"], name: "index_menus_on_company_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "menu_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_order_items_on_menu_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "total", default: 0
    t.bigint "company_id"
    t.bigint "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_orders_on_board_id"
    t.index ["company_id"], name: "index_orders_on_company_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.integer "price"
    t.string "description"
    t.string "brand"
    t.bigint "category_id"
    t.bigint "supplier_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "phone"
    t.string "identification"
    t.string "contact_name"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_suppliers_on_company_id"
  end

  create_table "transaktions", force: :cascade do |t|
    t.integer "quantity"
    t.integer "kind", default: 0
    t.bigint "employee_id"
    t.bigint "company_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_transaktions_on_company_id"
    t.index ["employee_id"], name: "index_transaktions_on_employee_id"
    t.index ["product_id"], name: "index_transaktions_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendances", "employees"
  add_foreign_key "boards", "companies"
  add_foreign_key "categories", "companies"
  add_foreign_key "companies", "users"
  add_foreign_key "employees", "companies"
  add_foreign_key "menu_items", "menus"
  add_foreign_key "menu_items", "products"
  add_foreign_key "menus", "categories"
  add_foreign_key "menus", "companies"
  add_foreign_key "order_items", "menus"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "boards"
  add_foreign_key "orders", "companies"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "companies"
  add_foreign_key "products", "suppliers"
  add_foreign_key "suppliers", "companies"
  add_foreign_key "transaktions", "companies"
  add_foreign_key "transaktions", "employees"
  add_foreign_key "transaktions", "products"
end
