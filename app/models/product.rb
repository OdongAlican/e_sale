# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :seller, class_name: 'User', foreign_key: 'user_id'
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true

  def self.created_products
    @products = Product.all.where(status: 'created').order('created_at DESC')
  end

  def self.pending_purchases(current_user)
    @products = Product.all.where(status: 'pending', buyer_id: current_user.id).order('created_at DESC')
  end

  def self.purchased_products(current_user)
    @products = Product.all.where(status: 'purchased', buyer_id: current_user.id).order('created_at DESC')
  end

  def self.pending_sales(current_user)
    @products = Product.all.where(status: 'pending', seller_id: current_user.id).order('created_at DESC')
  end
end
