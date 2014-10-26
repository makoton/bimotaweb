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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20141025234704) do

  create_table "clients", :force => true do |t|
    t.string   "names"
    t.string   "last_names"
    t.string   "rut"
    t.string   "contact_phone"
    t.string   "address"
    t.string   "comments"
    t.string   "email"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "clients", ["rut"], :name => "index_clients_on_rut", :unique => true

  create_table "maintenances", :force => true do |t|
    t.string  "kilometraje"
    t.integer "base_price"
    t.integer "labor_cost"
  end

  create_table "orders", :force => true do |t|
    t.string  "current_state"
    t.date    "finished_at"
    t.integer "client_id"
    t.integer "vehicle_id"
    t.string  "uuid"
  end

  add_index "orders", ["uuid"], :name => "index_orders_on_uuid", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "services", :force => true do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.integer  "labor_cost"
    t.integer  "total_cost"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "settings", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "supplies", :force => true do |t|
    t.string   "brand"
    t.string   "model"
    t.integer  "price"
    t.string   "type"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "supplies", ["category"], :name => "index_supplies_on_category"
  add_index "supplies", ["model"], :name => "index_supplies_on_model"

  create_table "supply_categories", :force => true do |t|
    t.string   "name"
    t.string   "supply_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "supply_items", :force => true do |t|
    t.integer  "supply_id"
    t.string   "status"
    t.integer  "service_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invitations_count"], :name => "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vehicles", :force => true do |t|
    t.string   "brand"
    t.string   "model"
    t.integer  "year"
    t.string   "license_plate"
    t.string   "chassis_number"
    t.integer  "kilometraje"
    t.string   "type"
    t.integer  "client_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "vehicles", ["brand"], :name => "index_vehicles_on_brand"
  add_index "vehicles", ["client_id"], :name => "index_vehicles_on_client_id"
  add_index "vehicles", ["license_plate"], :name => "index_vehicles_on_license_plate"
  add_index "vehicles", ["model"], :name => "index_vehicles_on_model"

end
