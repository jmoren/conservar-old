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

ActiveRecord::Schema.define(:version => 20110530193339) do

  create_table "det_categories", :force => true do |t|
    t.string   "name"
    t.text     "suggestion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deteriorations", :force => true do |t|
    t.integer  "report_id"
    t.string   "place"
    t.text     "description"
    t.integer  "det_category_id"
    t.boolean  "fixed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", :force => true do |t|
    t.integer  "galleryable_id"
    t.string   "galleryable_type"
    t.text     "description"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.date     "start_date"
    t.date     "end_date"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "report_id"
    t.integer  "deterioration_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "closed_at"
  end

  create_table "tools", :force => true do |t|
    t.integer  "task_id"
    t.string   "category"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
