# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :seller, class_name: 'User', foreign_key: 'user_id'
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
end
