# frozen_string_literal: true

# app/representers/user_representer.rb
class UserRepresenter
  def initialize(user)
    @user = user
  end

  def as_json
    {
      id: user.id,
      email: user.email,
      firstname: user.firstname,
      username: user.username,
      lastname: user.lastname,
      token: AuthenticationTokenService.call(user.id)
    }
  end

  private

  attr_reader :user
end
