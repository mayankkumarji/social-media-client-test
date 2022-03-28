# frozen_string_literal: true

require_relative '../app/models/user'
user = User.create(username: 'admin', password: 'pass')
Post.create(title: 'test title', content: 'test content', user_id: user.id)
