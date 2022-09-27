# frozen_string_literal: true

class ApplicationController < ActionController::API
  # include ActionController::RequestForgeryProtection
  include Response
  include Password

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # protect_from_forgery unless: -> { request.format.json? }
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def authenticate_request!
    return invalid_authentication if !payload || !AuthenticationTokenService.valid_payload(payload.first)

    current_user!
    invalid_authentication unless @current_user
  end

  def current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end

  private

  def not_found
    render json: { error: 'Not Found' }, status: :not_found
  end

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split.last
    AuthenticationTokenService.decode(token)
  rescue StandardError
    nil
  end

  def invalid_authentication
    render json: { error: 'You will need to login first' }, status: :unauthorized
  end
end
