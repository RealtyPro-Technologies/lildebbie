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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121203153932) do

  create_table "invitations", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.string   "code",        :null => false
    t.datetime "accepted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "project_grants", :force => true do |t|
    t.integer  "project_id",  :null => false
    t.integer  "user_id",     :null => false
    t.datetime "accepted_at"
    t.datetime "declined_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "owner_id",   :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "targets", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "project_id",                    :null => false
    t.string   "url"
    t.boolean  "active",     :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",      :null => false
    t.string   "email",         :null => false
    t.string   "password_salt", :null => false
    t.string   "password_hash", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
