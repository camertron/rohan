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

ActiveRecord::Schema.define(version: 20180622153758) do

  create_table "categories", force: :cascade do |t|
    t.string "title", limit: 255
  end

  create_table "discount_location_types", force: :cascade do |t|
  end

  create_table "location", force: :cascade do |t|
    t.string "branch_name", limit: 255
  end

  create_table "managers", force: :cascade do |t|
    t.string "username", limit: 255
  end

  create_table "merchant_staffs", force: :cascade do |t|
    t.string "username", limit: 255
  end

  create_table "order_data", force: :cascade do |t|
    t.integer "order_id",                  limit: 4
    t.integer "category_id",               limit: 4
    t.integer "discount_location_type_id", limit: 4
  end

  create_table "order_item_returns", force: :cascade do |t|
    t.integer "order_datum_id", limit: 4
  end

  create_table "order_statuses", force: :cascade do |t|
    t.integer "order_id",      limit: 4
    t.integer "attendee_id",   limit: 4
    t.string  "attendee_type", limit: 255
    t.integer "till_id",       limit: 4
  end

  create_table "orders", force: :cascade do |t|
    t.integer "location_id", limit: 4
  end

  create_table "tills", force: :cascade do |t|
  end

end
