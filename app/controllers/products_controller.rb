# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authorized, except: %i[show]
  before_action :find_product, only: %i[update show destroy buy]

  def index
    @products = Product.all.limit(10)
    json_response(@products, :created)
  end

  def create
    data = { **product_params, status: 'created' }

    data = current_user.products.create!(data)
    json_response(data, :created)
  end

  def show
    json_response(@product, :created)
  end

  def buy
    if @product.user_id == current_user.id
      json_response({ message: 'You can not buy your own product' }, :created)
    elsif @product.status == 'created'
      data = { **product_params, status: 'pending', buyer_id: current_user.id }
      if @product.update(data)
        json_response(@product, :created)
      else
        json_response('Cannot update')
      end
    else
      json_response({ message: 'Product has already been requested for' }, :created)
    end
  end

  def update
    if @product.update(product_params)
      json_response(@product, :created)
    else
      json_response('Cannot update')
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found', :unprocessable_entity)
  end

  def product_params
    params.require(:product).permit(:productname, :productprice)
  end
end
