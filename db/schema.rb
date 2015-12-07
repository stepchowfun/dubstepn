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

ActiveRecord::Schema.define(version: 20151207093405) do

  create_table "posts", force: :cascade do |t|
    t.text     "title",        null: false
    t.text     "content",      null: false
    t.boolean  "is_public",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "content_html", null: false
    t.integer  "sort_id",      null: false
    t.text     "javascript",   null: false
    t.text     "css",          null: false
    t.text     "title_html",   null: false
  end

  add_index "posts", ["is_public", "sort_id"], name: "index_posts_on_is_public_and_sort_id"
  add_index "posts", ["is_public"], name: "index_posts_on_is_public"
  add_index "posts", ["sort_id"], name: "index_posts_on_sort_id"

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "posts_tags", ["post_id"], name: "index_posts_tags_on_post_id"
  add_index "posts_tags", ["tag_id"], name: "index_posts_tags_on_tag_id"

  create_table "redirects", force: :cascade do |t|
    t.text     "from",       null: false
    t.text     "to",         null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name"

end
