# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :gender
      t.boolean :admin
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
