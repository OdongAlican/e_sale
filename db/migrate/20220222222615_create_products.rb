# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :productname
      t.string :productprice
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.belongs_to :seller, null: true
      t.belongs_to :buyer, null: true

      t.timestamps
    end
    add_foreign_key :products, :users, column: :seller_id
    add_foreign_key :products, :users, column: :buyer_id
  end
end
