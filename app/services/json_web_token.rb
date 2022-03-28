# frozen_string_literal: true

require 'jwt'
require 'active_record'
class JsonWebToken
  SECRET_KEY = 'testapp'

  def self.authorize_request(request)
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = decode(header)
      current_user = User.find(decoded[:user_id])
      { current_user: current_user, status: 200 }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY)[0]
  end
end
