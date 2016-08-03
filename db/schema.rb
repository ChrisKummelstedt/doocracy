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

ActiveRecord::Schema.define(version: 20160803104841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "binders", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string   "budget_item"
    t.integer  "quantity"
    t.float    "cost_per_item"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "team_id"
  end

  add_index "budgets", ["team_id"], name: "index_budgets_on_team_id", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "tags",               default: [],                      array: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "inventory_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "owner",              default: "--- []\n"
    t.string   "borrowed_by",        default: "--- []\n"
    t.string   "borrow_secret_key"
    t.string   "borrow_status"
  end

  add_index "items", ["inventory_id"], name: "index_items_on_inventory_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "total_budget"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "controller",         default: "--- []\n"
    t.integer  "revenue"
    t.string   "focus"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "receipts", force: :cascade do |t|
    t.string   "name"
    t.date     "date"
    t.integer  "amount"
    t.boolean  "booked"
    t.datetime "bookeddate"
    t.boolean  "approved"
    t.integer  "approvedby"
    t.datetime "approveddate"
    t.boolean  "paid"
    t.integer  "paidby"
    t.date     "paiddate"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "binder_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
    t.integer  "team_id"
    t.string   "notapproved"
    t.integer  "umbrella"
  end

  add_index "receipts", ["binder_id"], name: "index_receipts_on_binder_id", using: :btree
  add_index "receipts", ["team_id"], name: "index_receipts_on_team_id", using: :btree
  add_index "receipts", ["user_id"], name: "index_receipts_on_user_id", using: :btree

  create_table "skilllists", force: :cascade do |t|
    t.string   "skill"
    t.string   "skilllevel"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "skill"
    t.string   "skilllevel"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "skills_users", id: false, force: :cascade do |t|
    t.integer "skill_id"
    t.integer "user_id"
  end

  create_table "stacks", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "project_id"
    t.integer  "inventory_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "project_id"
    t.float    "team_budget"
    t.integer  "size"
  end

  add_index "teams", ["project_id"], name: "index_teams_on_project_id", using: :btree

  create_table "teams_users", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  create_table "todos", force: :cascade do |t|
    t.string   "description"
    t.string   "priority"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "team_id"
    t.boolean  "completed",   default: false, null: false
    t.integer  "user_id"
  end

  add_index "todos", ["team_id"], name: "index_todos_on_team_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "user_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "bio"
    t.string   "provider"
    t.string   "uid"
    t.string   "phone_number"
    t.string   "skype"
    t.string   "city"
    t.string   "country"
    t.string   "paypal"
    t.string   "iban"
    t.string   "swift"
    t.string   "swish"
    t.string   "choice"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "budgets", "teams"
  add_foreign_key "items", "inventories"
  add_foreign_key "projects", "users"
  add_foreign_key "receipts", "binders"
  add_foreign_key "receipts", "teams"
  add_foreign_key "receipts", "users"
  add_foreign_key "teams", "projects"
  add_foreign_key "todos", "teams"
end
