# frozen_string_literal: true

require 'roda'
require './app/main'
class App < Roda
  plugin :request_headers
  plugin :default_headers, 'Content-Type'=>'text/json'
  route do |r|
    # GET /login request
    r.get 'login' do
      username = r.params['username']
      password = r.params['password']
      ip = r.ip
      authenticate = User.authentication(username: username, password: password, ip: ip)
      authenticate.to_json
    end

    # /posts request
    r.on 'posts' do
      body = JSON.parse(r.body.read)
      header = r.headers['Authentication']
      auth = JwtWebToken.authorize_request(header)

      # /posts/create request to craete new post
      r.post 'create' do
        if auth[:status] == 200
          create_post = Post.create_post(params: body, auth: auth)
          create_post.to_json
        else
          { error: 'Authentication error!', status: 422 }.to_json
        end
      end

      # /top_post request
      r.get 'top_post' do
        if auth[:status] == 200
          top_post_response = Post.top_post
          top_post_response.to_json
        else
          { error: 'Authentication error!', status: 422 }.to_json
        end
      end

      # :post_id/ratings request
      r.on Integer, 'ratings' do |post_id|
        post = post_id
        # create rating for the post
        r.post 'create' do
          if auth[:status] == 200
            rating_response = Rating.create_rating(params: body, post: post)
            rating_response.to_json
          else
            { error: 'Authentication error!', status: 422 }.to_json
          end
        end
      end
    end
  end
end

run App.freeze.app
