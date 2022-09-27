# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post 'login', to: 'authentication#create'
  post 'signup', to: 'users#signup'
  # post 'login', to: 'users#login'
  # post 'signup', to: 'users#signup'
  put 'product/:id', to: 'products#buy'
  get 'pending-purchases', to: 'products#pending_purchases'
  get 'pending-sales', to: 'products#pending_sales'
  get 'purchased-products', to: 'products#purchased_products'

  resources :users
  resources :products
end
