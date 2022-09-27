# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :products
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
