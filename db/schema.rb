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

ActiveRecord::Schema.define(version: 20171108145743) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.string   "title"
    t.boolean  "is_right",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "uuid"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_categories_on_uuid", unique: true
  end

  create_table "complains", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "content"
    t.boolean  "is_replied",  default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "quiz_id"
    t.index ["question_id"], name: "index_complains_on_question_id"
    t.index ["user_id"], name: "index_complains_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "complain_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_favorites_on_question_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "feelings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.string   "value",       default: ""
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["question_id"], name: "index_feelings_on_question_id"
    t.index ["user_id"], name: "index_feelings_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "subject"
    t.integer  "conversation_id"
    t.text     "content"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "is_read",         default: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.text     "content"
    t.boolean  "is_read",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.integer  "category_id"
    t.integer  "type_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_questions_on_category_id"
    t.index ["type_id"], name: "index_questions_on_type_id"
  end

  create_table "quiz_details", force: :cascade do |t|
    t.integer  "quiz_id"
    t.integer  "question_id"
    t.integer  "choice_id"
    t.boolean  "is_correct",       default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id"
    t.integer  "quiz_question_id"
    t.index ["choice_id"], name: "index_quiz_details_on_choice_id"
    t.index ["question_id"], name: "index_quiz_details_on_question_id"
    t.index ["quiz_id"], name: "index_quiz_details_on_quiz_id"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.integer  "quiz_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_quiz_questions_on_question_id"
    t.index ["quiz_id"], name: "index_quiz_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string   "title"
    t.integer  "category_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "questions_count", default: 0
    t.boolean  "is_hidden",       default: true
    t.string   "quiz_type",       default: ""
  end

  create_table "types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_admin",               default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
