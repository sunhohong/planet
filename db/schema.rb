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

ActiveRecord::Schema.define(:version => 20120127150807) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "seq"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_meta", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "has_values"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_values", :force => true do |t|
    t.integer  "meta_id"
    t.string   "value"
    t.integer  "seq"
    t.string   "name"
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "title"
    t.string   "category"
    t.text     "description"
    t.string   "represent_image"
    t.integer  "price"
    t.integer  "location_id"
    t.string   "contact"
    t.boolean  "contact_allow"
    t.integer  "shipping_cost"
    t.string   "shipping_method"
    t.boolean  "deleted"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "step"
    t.boolean  "confirmed"
  end

  create_table "location_raw", :id => false, :force => true do |t|
    t.string "code", :limit => 45, :null => false
    t.string "si",   :limit => 45
    t.string "gu",   :limit => 45
    t.string "dong", :limit => 45
  end

  create_table "location_raw2", :id => false, :force => true do |t|
    t.string "code", :limit => 45, :null => false
    t.string "si",   :limit => 45
    t.string "gu",   :limit => 45
    t.string "dong", :limit => 45
  end

  create_table "locations", :force => true do |t|
    t.string   "postal_code"
    t.string   "si"
    t.string   "gu"
    t.string   "dong"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.string   "description"
    t.integer  "attachable_id"
    t.integer  "seq"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  create_table "tests", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
