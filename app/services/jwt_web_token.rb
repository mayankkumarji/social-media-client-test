# frozen_string_literal: true

require 'jwt'
require_relative '../main'
class JwtWebToken
  SECRET_KEY = 'testapp'

  def self.authorize_request(header_content)
    header = header_content
    begin
      decoded = decode(header)
      current_user = User.find(decoded['user_id'])
      ip = decoded['ip']
      { current_user: current_user, ip: ip, status: 200 }
    rescue ActiveRecord::RecordNotFound => e
      { errors: e.message, status: 402 }
    rescue JWT::DecodeError => e
      { errors: e.message, status: 500 }
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
