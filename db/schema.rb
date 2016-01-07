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

ActiveRecord::Schema.define(version: 20160106235212) do

  create_table "bike_brands", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bike_brands", ["name"], name: "index_bike_brands_on_name", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "names",         limit: 255
    t.string   "last_names",    limit: 255
    t.string   "rut",           limit: 255
    t.string   "contact_phone", limit: 255
    t.string   "address",       limit: 255
    t.string   "comments",      limit: 255
    t.string   "email",         limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "clients", ["rut"], name: "index_clients_on_rut", unique: true, using: :btree

  create_table "maintenances", force: :cascade do |t|
    t.string  "kilometraje", limit: 255
    t.integer "base_price",  limit: 4
    t.integer "labor_cost",  limit: 4
  end

  create_table "orders", force: :cascade do |t|
    t.string  "current_state", limit: 255
    t.date    "finished_at"
    t.integer "client_id",     limit: 4
    t.integer "vehicle_id",    limit: 4
    t.string  "uuid",          limit: 255
  end

  add_index "orders", ["uuid"], name: "index_orders_on_uuid", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4
    t.integer "user_id", limit: 4
  end

  create_table "services", force: :cascade do |t|
    t.integer  "order_id",    limit: 4
    t.integer  "user_id",     limit: 4
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.integer  "labor_cost",  limit: 4
    t.integer  "total_cost",  limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplies", force: :cascade do |t|
    t.string   "brand",      limit: 255
    t.string   "model",      limit: 255
    t.integer  "price",      limit: 4
    t.string   "type",       limit: 255
    t.string   "category",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "supplies", ["category"], name: "index_supplies_on_category", using: :btree
  add_index "supplies", ["model"], name: "index_supplies_on_model", using: :btree

  create_table "supply_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "supply_type", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "supply_items", force: :cascade do |t|
    t.integer  "supply_id",  limit: 4
    t.string   "status",     limit: 255
    t.integer  "service_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       limit: 4
    t.integer  "invited_by_id",          limit: 4
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",      limit: 4,   default: 0
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.string   "model",          limit: 255
    t.integer  "year",           limit: 4
    t.string   "license_plate",  limit: 255
    t.string   "chassis_number", limit: 255
    t.integer  "kilometraje",    limit: 4
    t.string   "type",           limit: 255
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "bike_brand_id",  limit: 4
  end

  add_index "vehicles", ["license_plate"], name: "index_vehicles_on_license_plate", using: :btree
  add_index "vehicles", ["model"], name: "index_vehicles_on_model", using: :btree
  add_index "vehicles", ["user_id"], name: "index_vehicles_on_user_id", using: :btree

end
