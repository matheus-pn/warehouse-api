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

ActiveRecord::Schema[7.0].define(version: 2022_05_21_221005) do
  create_table "divisions", force: :cascade do |t|
    t.string "parent_type", null: false
    t.integer "parent_id", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_type", "parent_id"], name: "index_divisions_on_parent"
  end

  create_table "enterprises", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "division_id", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_inventories_on_division_id"
  end

  create_table "inventory_products", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "inventory_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_id"], name: "index_inventory_products_on_inventory_id"
    t.index ["product_id"], name: "index_inventory_products_on_product_id"
  end

  create_table "product_relations", force: :cascade do |t|
    t.integer "mode", default: 0, null: false
    t.integer "parent_id", null: false
    t.integer "child_id", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_product_relations_on_child_id"
    t.index ["parent_id"], name: "index_product_relations_on_parent_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "enterprise_id", null: false
    t.integer "mode", default: 0, null: false
    t.string "name", default: "", null: false
    t.string "code", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enterprise_id", "code"], name: "index_products_on_enterprise_id_and_code", unique: true
    t.index ["enterprise_id"], name: "index_products_on_enterprise_id"
  end

  create_table "tag_relations", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.string "owner_type", null: false
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_tag_relations_on_owner"
    t.index ["tag_id"], name: "index_tag_relations_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_sessions", force: :cascade do |t|
    t.string "token", null: false
    t.integer "user_id", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "enterprise_id", null: false
    t.string "password_digest", null: false
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enterprise_id"], name: "index_users_on_enterprise_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "virtual_inventories", force: :cascade do |t|
    t.integer "division_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_virtual_inventories_on_division_id"
  end

  create_table "virtual_inventory_relations", force: :cascade do |t|
    t.integer "parent_id", null: false
    t.integer "child_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_virtual_inventory_relations_on_child_id"
    t.index ["parent_id"], name: "index_virtual_inventory_relations_on_parent_id"
  end

  add_foreign_key "inventories", "divisions"
  add_foreign_key "inventory_products", "inventories"
  add_foreign_key "inventory_products", "products"
  add_foreign_key "product_relations", "products", column: "child_id"
  add_foreign_key "product_relations", "products", column: "parent_id"
  add_foreign_key "products", "enterprises"
  add_foreign_key "tag_relations", "tags"
  add_foreign_key "user_sessions", "users"
  add_foreign_key "users", "enterprises"
  add_foreign_key "virtual_inventories", "divisions"
  add_foreign_key "virtual_inventory_relations", "inventories", column: "child_id"
  add_foreign_key "virtual_inventory_relations", "virtual_inventories", column: "parent_id"
end
