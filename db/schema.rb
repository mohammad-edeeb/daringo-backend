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

ActiveRecord::Schema.define(version: 20171215165200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.bigint "subscription_id"
    t.string "text"
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["subscription_id"], name: "index_blocks_on_subscription_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "end_date"
    t.integer "num_of_blocks"
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.boolean "completed", default: false
    t.bigint "winner_id"
    t.index ["user_id"], name: "index_challenges_on_user_id"
    t.index ["winner_id"], name: "index_challenges_on_winner_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "challenge_id"
    t.string "condition"
    t.boolean "winner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "can_edit", default: true
    t.index ["challenge_id"], name: "index_subscriptions_on_challenge_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "image_url"
    t.string "email"
    t.string "account_type"
    t.string "social_account_id"
    t.string "social_account_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "token"
    t.string "fcm_token"
  end

  add_foreign_key "blocks", "subscriptions"
  add_foreign_key "challenges", "users"
  add_foreign_key "challenges", "users", column: "winner_id"
  add_foreign_key "subscriptions", "challenges"
  add_foreign_key "subscriptions", "users"
end
