# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorized, except: %i[login signup]
  before_action :find_user, only: %i[update show destroy]

  def index
    @users = User.all.limit(10).to_json({ include: 'products' })
    json_response(@users, :created)
  end

  def signup
    @user = User.create(user_params)
    if @user.save
      json_response(@user, :created)
    else
      json_response('Can not be created', :unprocessable_entity)
    end
  end

  def show
    json_response(@user, :created)
  end

  def update
    if @user.update(user_params)
      json_response(@user, :created)
    else
      json_response('Cannot update')
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    password = params.permit(:password)
    if @user && @user.password_digest == password['password']
      token = encode_token({ user_id: @user.id })
      data = { user: @user, token: token }
      json_response(data, :ok)
    else
      json_response({ status: 'error', message: 'Invalid Email or Password' }, :unauthorized)
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
