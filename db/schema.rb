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

ActiveRecord::Schema.define(version: 20170910072023) do

  create_table "deelnemers", force: :cascade do |t|
    t.string "voornaam"
    t.string "achternaam"
    t.string "tussenvoegsel"
    t.date "geboortedatum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "telefoonnummer"
    t.integer "knsbnummer"
    t.integer "rating"
  end

  create_table "deelnemers_groeps", id: false, force: :cascade do |t|
    t.integer "deelnemer_id", null: false
    t.integer "groep_id", null: false
  end

  create_table "deelnemers_toernoois", id: false, force: :cascade do |t|
    t.integer "deelnemer_id", null: false
    t.integer "toernooi_id", null: false
  end

  create_table "groeps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "toernooi_id"
    t.integer "nummer"
  end

  create_table "partijs", force: :cascade do |t|
    t.string "uitslag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "groep_id"
    t.integer "witspeler_id"
    t.integer "zwartspeler_id"
  end

  create_table "toernoois", force: :cascade do |t|
    t.string "naam"
    t.string "wedstrijdleider"
    t.date "datum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
