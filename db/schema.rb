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

ActiveRecord::Schema.define(version: 20170406133625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "logins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "site_id"
    t.string   "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_token"], name: "index_logins_on_auth_token", unique: true, using: :btree
    t.index ["user_id", "site_id"], name: "index_logins_on_user_id_and_site_id", unique: true, using: :btree
  end

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "secret_key"
    t.string   "user_update_callback"
    t.string   "auth_token_callback"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["auth_token_callback"], name: "index_sites_on_auth_token_callback", unique: true, using: :btree
    t.index ["domain"], name: "index_sites_on_domain", unique: true, using: :btree
    t.index ["secret_key"], name: "index_sites_on_secret_key", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "auth_digest"
    t.index ["auth_digest"], name: "index_users_on_auth_digest", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
