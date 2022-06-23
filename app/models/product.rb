# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :seller, class_name: 'User', foreign_key: 'user_id'
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true

  def self.created_products
    @products = Product.all.where(status: 'created').limit(10).to_json({ include: 'buyer' })
  end

  def self.pending_products
    @products = Product.all.where(status: 'pending').limit(10).to_json({ include: 'buyer' })
  end

  def self.purchased_products
    @products = Product.all.where(status: 'purchased').limit(10).to_json({ include: 'buyer' })
  end
end
