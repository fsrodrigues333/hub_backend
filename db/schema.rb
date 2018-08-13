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

ActiveRecord::Schema.define(version: 2018_08_13_132914) do

  create_table "account_attrs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "group_account_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_attrs_on_account_id"
    t.index ["group_account_id"], name: "index_account_attrs_on_group_account_id"
  end

  create_table "account_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.boolean "active"
    t.bigint "person_id"
    t.bigint "account_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id"
    t.index ["person_id"], name: "index_accounts_on_person_id"
  end

  create_table "group_accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_group_accounts_on_account_id"
  end

  create_table "people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "register"
    t.string "name2"
    t.datetime "birth_date"
    t.bigint "person_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_type_id"], name: "index_people_on_person_type_id"
  end

  create_table "person_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "revokes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "transaction_id"
    t.bigint "transaction_eq"
    t.string "code"
    t.boolean "check"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transaction_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "transaction_type_id"
    t.float "value"
    t.bigint "account_receive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
  end

  add_foreign_key "account_attrs", "accounts"
  add_foreign_key "account_attrs", "group_accounts"
  add_foreign_key "accounts", "account_types"
  add_foreign_key "accounts", "people"
  add_foreign_key "group_accounts", "accounts"
  add_foreign_key "people", "person_types"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "transaction_types"
end
