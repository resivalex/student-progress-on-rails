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

ActiveRecord::Schema.define(version: 20160225224725) do

  create_table "auditories", force: :cascade do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "subject_id"
    t.integer  "auditory_id"
    t.integer  "user_id"
    t.datetime "time"
  end

  add_index "lessons", ["auditory_id"], name: "index_lessons_on_auditory_id"
  add_index "lessons", ["group_id"], name: "index_lessons_on_group_id"
  add_index "lessons", ["subject_id"], name: "index_lessons_on_subject_id"
  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id"

  create_table "mark_tracks", force: :cascade do |t|
    t.string   "name"
    t.integer  "mark_id"
    t.text     "comment"
    t.datetime "created_at"
  end

  add_index "mark_tracks", ["mark_id"], name: "index_mark_tracks_on_mark_id"

  create_table "marks", force: :cascade do |t|
    t.integer "student_id"
    t.integer "lesson_id"
  end

  add_index "marks", ["lesson_id"], name: "index_marks_on_lesson_id"
  add_index "marks", ["student_id"], name: "index_marks_on_student_id"

  create_table "students", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  add_index "students", ["group_id"], name: "index_students_on_group_id"
  add_index "students", ["user_id"], name: "index_students_on_user_id"

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "patronymic"
    t.string "login"
    t.string "password"
    t.string "role"
    t.string "email"
    t.string "phone"
  end

end