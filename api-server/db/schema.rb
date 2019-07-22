# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_19_211835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_hoc_query_lists", force: :cascade do |t|
    t.boolean "has_run", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ad_hoc_query_lists_queries", force: :cascade do |t|
    t.bigint "ad_hoc_query_list_id"
    t.bigint "query_id"
    t.index ["ad_hoc_query_list_id"], name: "index_ad_hoc_query_lists_queries_on_ad_hoc_query_list_id"
    t.index ["query_id"], name: "index_ad_hoc_query_lists_queries_on_query_id"
  end

  create_table "configs", force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "data", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.bigint "config_id"
    t.string "node_key"
    t.string "host_identifier"
    t.string "platform_type"
    t.string "os_platform"
    t.string "os_major"
    t.string "os_minor"
    t.string "os_name"
    t.string "os_patch"
    t.string "os_version"
    t.string "sys_computer_name"
    t.string "sys_cpu_brand"
    t.string "sys_cpu_logical_cores"
    t.string "sys_cpu_microcode"
    t.string "sys_cpu_physical_cores"
    t.string "sys_cpu_subtype"
    t.string "sys_cpu_type"
    t.string "sys_hardware_model"
    t.string "sys_hostname"
    t.string "sys_local_hostname"
    t.string "sys_physical_memory"
    t.string "sys_uuid"
    t.string "osqi_build_distro"
    t.string "osqi_build_platform"
    t.string "osqi_config_hash"
    t.string "osqi_config_valid"
    t.string "osqi_extensions"
    t.string "osqi_instance_id"
    t.string "osqi_pid"
    t.string "osqi_start_time"
    t.string "osqi_uuid"
    t.string "osqi_version"
    t.index ["config_id"], name: "index_nodes_on_config_id"
    t.index ["node_key"], name: "index_nodes_on_node_key"
  end

  create_table "queries", force: :cascade do |t|
    t.text "name", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string "attack_name", null: false
    t.string "result", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "nodes", "configs"
end
