# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  attributes :firstname, :lastname, :email, :password, :username, :gender, :admin, :created_at, :updated_at
end
