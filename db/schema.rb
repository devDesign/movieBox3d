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

ActiveRecord::Schema.define(version: 20141006012419) do

  create_table "actors", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.string   "role"
    t.integer  "user_id"
    t.integer  "movies_id"
    t.string   "picture"
  end

  add_index "actors", ["movies_id"], name: "index_actors_on_movies_id"
  add_index "actors", ["user_id"], name: "index_actors_on_user_id"

  create_table "genres", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "movies_id"
    t.string   "genre"
    t.integer  "movie_id"
  end

  add_index "genres", ["movie_id"], name: "index_genres_on_movie_id"
  add_index "genres", ["movies_id"], name: "index_genres_on_movies_id"

  create_table "genres_tables", force: true do |t|
    t.integer "movies_id"
  end

  create_table "movies", force: true do |t|
    t.string   "title"
    t.string   "director"
    t.integer  "runtime_in_minutes"
    t.text     "description"
    t.string   "poster_image_url"
    t.string   "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "year"
    t.string   "status"
    t.integer  "budget"
    t.string   "tag_line"
    t.string   "imbd"
    t.string   "trailer"
    t.string   "backdrop_image_url"
  end

  create_table "posters", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.text     "text"
    t.integer  "rating_out_of_ten"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["movie_id"], name: "index_reviews_on_movie_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "admin"
  end

end
