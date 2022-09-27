# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_request!, except: %i[login signup]
  before_action :find_user, only: %i[update show destroy]

  def index
    @users = User.all.limit(10).to_json({ include: 'products' })
    json_response(@users, :created)
  end

  def signup
    @user = User.create(user_params)
    if @user.save
      render json: UserSerializer.new(@user).serializable_hash
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: UserSerializer.new(@user).serializable_hash
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash
    else
      json_response('Cannot update')
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found', :unprocessable_entity)
  end

  def user_params
    params.permit(:firstname, :lastname, :email, :password, :username, :gender, :admin)
  end
end
