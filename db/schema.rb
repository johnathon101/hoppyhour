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

ActiveRecord::Schema.define(:version => 20140506050349) do

  create_table "beers", :force => true do |t|
    t.string   "brewery"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "ibu"
    t.float    "abv"
    t.text     "desc"
  end

  create_table "beers_places", :id => false, :force => true do |t|
    t.integer "beer_id",  :null => false
    t.integer "place_id", :null => false
  end

  add_index "beers_places", ["beer_id", "place_id"], :name => "index_beers_places_on_beer_id_and_place_id", :unique => true

  create_table "foods", :force => true do |t|
    t.string   "entree"
    t.string   "sides"
    t.integer  "daytime"
    t.text     "days"
    t.integer  "place_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "price"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "rating"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "lat"
    t.float    "lon"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                           :null => false
    t.string   "crypted_password",                :null => false
    t.string   "salt",                            :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
