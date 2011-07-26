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

ActiveRecord::Schema.define(:version => 20110725154302) do

  create_table "alerts", :force => true do |t|
    t.string   "alertable_type"
    t.integer  "alertable_id"
    t.text     "message"
    t.string   "frequency"
    t.integer  "custom"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "day"
  end

  create_table "collections", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "det_categories", :force => true do |t|
    t.string   "name"
    t.text     "suggestion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     :default => true
  end

  create_table "deteriorations", :force => true do |t|
    t.integer  "report_id"
    t.string   "place"
    t.text     "description"
    t.integer  "det_category_id"
    t.boolean  "fixed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "hours",           :default => 0.0
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "activity"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "all_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flaggings", :force => true do |t|
    t.string   "flaggable_type"
    t.integer  "flaggable_id"
    t.string   "flagger_type"
    t.integer  "flagger_id"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flaggings", ["flag", "flaggable_type", "flaggable_id"], :name => "index_flaggings_on_flag_and_flaggable_type_and_flaggable_id"
  add_index "flaggings", ["flag", "flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], :name => "access_flag_flaggings"
  add_index "flaggings", ["flaggable_type", "flaggable_id"], :name => "index_flaggings_on_flaggable_type_and_flaggable_id"
  add_index "flaggings", ["flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], :name => "access_flaggings"

  create_table "galleries", :force => true do |t|
    t.integer  "galleryable_id"
    t.string   "galleryable_type"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generic_boolean_fields", :force => true do |t|
    t.integer  "item_id"
    t.string   "label_attribute"
    t.boolean  "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generic_fields", :force => true do |t|
    t.integer  "item_category_id"
    t.string   "name"
    t.string   "field_style"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generic_float_fields", :force => true do |t|
    t.integer  "item_id"
    t.string   "label_attribute"
    t.float    "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generic_integer_fields", :force => true do |t|
    t.integer  "item_id"
    t.string   "label_attribute"
    t.integer  "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generic_select_fields", :force => true do |t|
    t.integer  "item_id"
    t.string   "label_attribute"
    t.string   "content"
    t.string   "options"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generic_text_areas", :force => true do |t|
    t.integer  "item_id"
    t.string   "label_attribute"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generic_text_fields", :force => true do |t|
    t.integer  "item_id"
    t.string   "label_attribute"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "histories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "historyable_id"
    t.string   "historyable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "history_changes", :force => true do |t|
    t.integer  "history_id"
    t.string   "field_change"
    t.text     "content_change"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "institutions", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "city"
    t.string   "country"
    t.string   "email"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_categories", :force => true do |t|
    t.string   "name"
    t.integer  "item_category_id"
    t.boolean  "active",           :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "collection_id"
    t.integer  "user_id"
    t.string   "code"
    t.string   "title"
    t.string   "author"
    t.text     "description"
    t.integer  "item_category_id"
    t.integer  "item_subcategory_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "observations", :force => true do |t|
    t.integer  "report_id"
    t.string   "category"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "gallery_id"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.string   "code"
    t.text     "comments"
    t.text     "treatment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.date     "start_date"
    t.date     "end_date"
    t.float    "hours",        :default => 0.0
    t.boolean  "archived"
    t.integer  "item_id"
    t.text     "conclusion"
    t.float    "budget_tools"
    t.float    "budget_work"
    t.integer  "assigned_to"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "tasks", :force => true do |t|
    t.integer  "report_id"
    t.integer  "deterioration_id"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "closed_at"
    t.float    "hours",            :default => 1.0
  end

  create_table "tools", :force => true do |t|
    t.integer  "task_id"
    t.string   "category"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "name"
    t.string   "lastname"
    t.boolean  "enabled",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "cached_slug"
  end

end
