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

ActiveRecord::Schema.define(version: 2019_05_13_154840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description", default: ""
    t.datetime "started_at"
    t.datetime "due_at"
    t.datetime "finished_at"
    t.datetime "paused_at"
    t.string "state", default: "newed", null: false
    t.string "slug", null: false
    t.index ["name", "user_id"], name: "index_projects_on_name_and_user_id", unique: true
    t.index ["name"], name: "index_projects_on_name"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "tasks", id: :serial, force: :cascade do |t|
    t.string "label", null: false
    t.datetime "planned_at"
    t.datetime "finished_at"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "abandoned_at"
    t.integer "planned_count", default: 0, null: false
    t.integer "order"
    t.integer "project_id"
    t.string "state", default: "newed", null: false
    t.datetime "started_at"
    t.index ["order"], name: "index_tasks_on_order"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "terms_of_services", force: :cascade do |t|
    t.text "content", null: false
    t.string "version", null: false
    t.datetime "effective_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.string "username"
    t.boolean "admin", default: false
    t.bigint "terms_of_service_id"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "time_zone", default: "UTC"
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["terms_of_service_id"], name: "index_users_on_terms_of_service_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "projects", "users"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "users"
  add_foreign_key "users", "terms_of_services"
end
