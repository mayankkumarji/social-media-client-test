# frozen_string_literal: true

require 'json'
class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :posts

  def self.authentication(username: nil, password: nil)
    user = User.find_by(username: username, password: password)

    if user.present?
      { data: user, status: 200, message: 'Login successfully!' }
    else
      { status: 404, message: 'Login failed!' }
    end
  end
end
