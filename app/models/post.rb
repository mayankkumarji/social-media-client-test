# frozen_string_literal: true

class Post < ActiveRecord::Base
  validates :title, :content, presence: true

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :ratings

  # create new post
  def self.create_post(params: nil, auth: nil)
    params = validate_auther(params, auth)
    post = check_exiting_post(params)
    return post if post.present?

    post = Post.new(params['posts'])
    if post.save
      { data: post, status: 200, message: 'Post create successfully!' }
    else
      { status: 422, message: 'Failed to create post!' }
    end
  end

  def self.check_exiting_post(params)
    post = Post.find_by(content: params['posts']['content'],
                        title: params['posts']['title'],
                        user_id: params['posts']['user_id'])
    return nil if post.blank?

    { data: post, status: 200, message: 'Post exits already!' }
  end

  # validate if auther exists and if not then create one
  def self.validate_auther(params, auth)
    return params if params['posts']['user_id'].blank?

    auther = check_auther(params['posts']['user_id'])
    unless auther.present?
      user_body = { 'user' => { username: params['posts']['user_id'], password: '1234' } }
      user = User.create_user(params: user_body)
      params['posts']['user_id'] = user[:data]&.id
    end
    params['posts']['auther_ip'] = auth[:ip]

    params
  end

  # check if auther exists and return auther
  def self.check_auther(user_id)
    auther = User.find_by(username: user_id)
    User.find_by(id: user_id) if auther.blank?
  end
end
