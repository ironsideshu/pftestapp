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

ActiveRecord::Schema.define(version: 20150311151146) do

  create_table "documents", force: :cascade do |t|
    t.string   "_id"
    t.string   "_rev"
    t.string   "barcode"
    t.string   "member_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.string   "member_type"
    t.string   "status_code"
    t.string   "status_code_descr"
    t.string   "is_active"
    t.string   "pay_status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "perks", force: :cascade do |t|
    t.string   "barcode"
    t.string   "program"
    t.string   "brand"
    t.string   "perk_name"
    t.string   "perk_descr"
    t.string   "open_time"
    t.string   "click_time"
    t.string   "redeemed_time"
    t.string   "redeemed_loc"
    t.string   "gross_amt"
    t.string   "discount_amt"
    t.string   "is_perk"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "results", force: :cascade do |t|
    t.string   "_id"
    t.string   "_rev"
    t.string   "barcode"
    t.string   "member_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.string   "member_type"
    t.string   "status_code"
    t.string   "status_code_descr"
    t.string   "is_active"
    t.string   "pay_status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
