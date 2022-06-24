# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authorized, except: %i[show]
  before_action :find_product, only: %i[update show destroy buy]

  def index
    @products = Product.created_products.paginate(page: params[:page], per_page: 10).to_json({ include: 'buyer' })
    json_response(@products, :created)
  end

  # Purchases

  def pending_purchases
    data = Product.pending_purchases(current_user).paginate(page: params[:page],
                                                            per_page: 10).to_json({ include: 'seller' })
    json_response(data, :created)
  end

  def purchased_products
    data = Product.purchased_products(current_user).paginate(page: params[:page],
                                                             per_page: 10).to_json({ include: 'seller' })
    json_response(data, :created)
  end

  # Sales

  def pending_sales
    data = Product.pending_sales(current_user).paginate(page: params[:page], per_page: 10).to_json({ include: 'buyer' })
    json_response(data, :created)
  end

  def create
    data = current_user.products.create!({ **product_params, status: 'created', seller_id: current_user.id })
    json_response(data, :created)
  end

  def show
    data = @product.to_json({ include: 'buyer' })
    json_response(data, :created)
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
