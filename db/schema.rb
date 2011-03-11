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

ActiveRecord::Schema.define(:version => 20110310171938) do

  create_table "comments", :force => true do |t|
    t.integer   "issue_id"
    t.string    "text"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "issues", :force => true do |t|
    t.string    "title"
    t.text      "description"
    t.float     "lat"
    t.float     "lon"
    t.integer   "radius"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "address"
    t.boolean   "resolved"
    t.string    "ip_address"
    t.text      "location"
    t.string    "city"
    t.string    "state"
    t.string    "country_code"
    t.string    "country_name"
    t.string    "street_address"
    t.string    "zipcode"
    t.integer   "vote_count",     :default => 0
    t.timestamp "resolved_at"
    t.integer   "resolver_id"
  end

  create_table "reports", :force => true do |t|
    t.integer   "user_id"
    t.string    "title"
    t.text      "description"
    t.float     "lat"
    t.float     "lon"
    t.integer   "radius"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "issue_id"
    t.string    "tags"
    t.text      "address"
    t.string    "ip_address"
    t.text      "location"
    t.string    "city"
    t.string    "state"
    t.string    "country_code"
    t.string    "country_name"
    t.string    "street_address"
    t.string    "zipcode"
  end

  create_table "solutions", :force => true do |t|
    t.string    "title"
    t.integer   "user_id"
    t.integer   "issue_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "user_tokens", :force => true do |t|
    t.integer   "user_id"
    t.string    "provider"
    t.string    "uid"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "email",                               :default => "", :null => false
    t.string    "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string    "reset_password_token"
    t.string    "remember_token"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                       :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "avatar_url"
    t.integer   "twitter_id"
    t.string    "name"
    t.integer   "points",                              :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.integer   "versioned_id"
    t.string    "versioned_type"
    t.integer   "user_id"
    t.string    "user_type"
    t.string    "user_name"
    t.text      "modifications"
    t.integer   "number"
    t.integer   "reverted_from"
    t.string    "tag"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["tag"], :name => "index_versions_on_tag"
  add_index "versions", ["user_id", "user_type"], :name => "index_versions_on_user_id_and_user_type"
  add_index "versions", ["user_name"], :name => "index_versions_on_user_name"
  add_index "versions", ["versioned_id", "versioned_type"], :name => "index_versions_on_versioned_id_and_versioned_type"

  create_table "votes", :force => true do |t|
    t.integer   "user_id"
    t.integer   "issue_id"
    t.integer   "solution_id"
    t.string    "type"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
