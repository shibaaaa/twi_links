# frozen_string_literal: true

ActiveRecord::Schema[7.0].define(version: 2022_08_12_052304) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "url", null: false
    t.string "tweet_url", null: false
    t.string "tweet_user_meta", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "tweeted_at", null: false
    t.string "tweet_id", null: false
    t.string "title", null: false
    t.text "image_meta", null: false
    t.index ["url"], name: "index_articles_on_url", unique: true
    t.index ["user_id", "tweeted_at"], name: "index_articles_on_user_id_and_tweeted_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "name", null: false
    t.string "access_token"
    t.string "access_token_secret"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "articles", "users"
end
