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

ActiveRecord::Schema.define(version: 20181022170151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "advertimages", id: :serial, force: :cascade do |t|
    t.string "image"
    t.integer "advert_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advert_id"], name: "index_advertimages_on_advert_id"
  end

  create_table "adverts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "client"
    t.string "linkurl"
    t.string "city"
    t.integer "admin_id"
    t.integer "viewcounter", default: 0, null: false
    t.integer "clickcounter", default: 0, null: false
    t.date "begin_ad"
    t.date "end_ad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_adverts_on_admin_id"
    t.index ["begin_ad"], name: "index_adverts_on_begin_ad"
    t.index ["city"], name: "index_adverts_on_city"
    t.index ["end_ad"], name: "index_adverts_on_end_ad"
  end

  create_table "answers", id: :serial, force: :cascade do |t|
    t.integer "message_id"
    t.string "content"
    t.integer "recipent"
    t.integer "sender"
    t.integer "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_answers_on_message_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "citynames", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departures", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["latitude"], name: "index_departures_on_latitude"
    t.index ["longitude"], name: "index_departures_on_longitude"
    t.index ["name"], name: "index_departures_on_name"
  end

  create_table "destinations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["latitude"], name: "index_destinations_on_latitude"
    t.index ["longitude"], name: "index_destinations_on_longitude"
    t.index ["name"], name: "index_destinations_on_name"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "content"
    t.integer "recipent"
    t.integer "sender"
    t.integer "user_id"
    t.integer "offer_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "senderclick"
    t.boolean "recipentclick"
    t.index ["offer_id"], name: "index_messages_on_offer_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "offers", id: :serial, force: :cascade do |t|
    t.string "departurelocal"
    t.date "departuredate"
    t.string "departuretime"
    t.string "destinationlocal"
    t.text "description"
    t.string "between_stops"
    t.boolean "seek"
    t.boolean "active"
    t.boolean "rules"
    t.integer "user_id"
    t.integer "departure_id"
    t.integer "destination_id"
    t.integer "viewcounter", default: 0
    t.integer "clickcounter", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "emailnotification", default: false
    t.index ["active"], name: "index_offers_on_active"
    t.index ["between_stops"], name: "index_offers_on_between_stops"
    t.index ["departure_id"], name: "index_offers_on_departure_id"
    t.index ["departuredate"], name: "index_offers_on_departuredate"
    t.index ["departurelocal"], name: "index_offers_on_departurelocal"
    t.index ["destination_id"], name: "index_offers_on_destination_id"
    t.index ["destinationlocal"], name: "index_offers_on_destinationlocal"
    t.index ["seek"], name: "index_offers_on_seek"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "email"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "emailmsgnotification"
  end

  add_foreign_key "advertimages", "adverts"
  add_foreign_key "adverts", "admins"
  add_foreign_key "answers", "messages"
  add_foreign_key "answers", "users"
  add_foreign_key "messages", "offers"
  add_foreign_key "messages", "users"
  add_foreign_key "offers", "departures"
  add_foreign_key "offers", "destinations"
  add_foreign_key "offers", "users"
end
