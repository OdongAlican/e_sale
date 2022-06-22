# frozen_string_literal: true

module Response
  def json_response(object, status = :ok)
    p '............'
    p '............'
    p object
    p '............'
    p '............'
    render json: object, status: status
  end
end
