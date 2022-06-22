# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_220_222_222_615) do
  create_table 'products', force: :cascade do |t|
    t.string 'productname'
    t.string 'productprice'
    t.string 'status'
    t.integer 'user_id', null: false
    t.integer 'seller_id'
    t.integer 'buyer_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['buyer_id'], name: 'index_products_on_buyer_id'
    t.index ['seller_id'], name: 'index_products_on_seller_id'
    t.index ['user_id'], name: 'index_products_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'firstname'
    t.string 'lastname'
    t.string 'username'
    t.string 'gender'
    t.boolean 'admin', default: false
    t.string 'email'
    t.string 'password'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'products', 'users'
  add_foreign_key 'products', 'users', column: 'buyer_id'
  add_foreign_key 'products', 'users', column: 'seller_id'
end
