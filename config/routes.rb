# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'login', to: 'users#login'
  post 'signup', to: 'users#signup'
  put 'product/:id', to: 'products#buy'
  get 'created-products', to: 'products#created_products'
  get 'pending-products', to: 'products#pending_products'
  get 'purchased-products', to: 'products#purchased_products'

  resources :users
  resources :products
end
