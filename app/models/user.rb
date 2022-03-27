# frozen_string_literal: true

require_relative '../services/jwt_web_token'
class User < ActiveRecord::Base
  validates :username, presence: true
  validates :password, presence: true

  has_many :posts

  def self.authentication(username: nil, password: nil, ip: nil)
    user = User.find_by(username: username, password: password)
    if user.present?
      payload = { user_id: user.id, ip: ip }
      token = JwtWebToken.encode(payload)
      { data: user, token: token, status: 200, message: 'Login successfully!' }
    else
      { status: 404, message: 'Login failed!' }
    end
  end

  def self.create_user(params: nil)
    user = User.new(params['user'])
    if user.save
      { data: user, status: 200, message: 'User created successfully!' }
    else
      { status: 500, message: 'Failed to create user!' }
    end
  end
end
