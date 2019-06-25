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

ActiveRecord::Schema.define(version: 2019_06_25_013551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adhoc_queries", force: :cascade do |t|
    t.jsonb "data"
    t.bigint "node_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["node_id"], name: "index_adhoc_queries_on_node_id"
  end

  create_table "configs", force: :cascade do |t|
    t.jsonb "data"
    t.bigint "node_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["node_id"], name: "index_configs_on_node_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.string "node_key"
    t.string "host_identifier"
    t.string "os_version"
    t.string "osquery_info"
    t.string "system_info"
    t.string "platform_info"
  end

  add_foreign_key "adhoc_queries", "nodes"
  add_foreign_key "configs", "nodes"
end
