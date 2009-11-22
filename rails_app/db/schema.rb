# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091122145036) do

  create_table "boots", :force => true do |t|
    t.integer "game_id",   :null => false
    t.integer "player_id"
  end

  create_table "cities", :force => true do |t|
    t.integer  "player_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "defenders_of_catan", :force => true do |t|
    t.integer  "game_id",    :null => false
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expansions", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "display_name", :null => false
    t.string   "description",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expansions", ["name"], :name => "index_expansions_on_name", :unique => true

  create_table "expansions_games", :id => false, :force => true do |t|
    t.integer  "game_id",      :null => false
    t.integer  "expansion_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.integer  "victory_points_to_win", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "knights", :force => true do |t|
    t.integer  "player_id",                     :null => false
    t.integer  "level"
    t.boolean  "activated",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "largest_armies", :force => true do |t|
    t.integer "game_id",   :null => false
    t.integer "player_id"
  end

  create_table "longest_roads", :force => true do |t|
    t.integer  "game_id",    :null => false
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "longest_roads", ["game_id"], :name => "index_longest_roads_on_game_id", :unique => true

  create_table "merchants", :force => true do |t|
    t.integer "game_id",   :null => false
    t.integer "player_id"
  end

  create_table "metropolises", :force => true do |t|
    t.integer "game_id",          :null => false
    t.integer "city_id"
    t.string  "development_area", :null => false
  end

  create_table "players", :force => true do |t|
    t.integer  "game_id",    :null => false
    t.string   "color",      :null => false
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["game_id", "color"], :name => "index_players_on_game_id_and_color", :unique => true

  create_table "settlements", :force => true do |t|
    t.integer  "player_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "soldiers", :force => true do |t|
    t.integer "game_id",   :null => false
    t.integer "player_id"
  end

end
