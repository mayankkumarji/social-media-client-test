# frozen_string_literal: true
require 'faker'

require_relative '../app/models/user'
require_relative '../app/models/post'
require_relative '../app/models/feedback'

user = User.create(username: 'admin', password: 'pass')
Post.create(title: 'test title', content: 'test content', user_id: user.id)


#Create 200k posts
200000.times do
  post = Post.new(
  	title: Faker::Lorem.sentence,
  	content: Faker::Lorem.paragraph(sentence_count: 1),
  	user_id: Faker::Number.between(from: 1, to: User.all.count)
  )
  post.save!
end
posts = Post.all

# Create feedbacks for posts
10000.times do
  post_feedback = Feedback.new(
  	comment: Faker::Lorem.sentence,
  	owner_id: Faker::Number.between(from: 1, to: User.all.count),
  	post_id: Faker::Number.between(from: 1, to: Post.all.count),
  	user_id: 2
  )
  post_feedback.save!
end
feedback_for_post = Feedback.all

# Create feedbacks for users
50.times do
  post_feedback = Feedback.new(
  	comment: Faker::Lorem.sentence,
  	owner_id: Faker::Number.between(from: 1, to: User.all.count),
  	user_id: Faker::Number.between(from: 1, to: User.all.count)
  )
  post_feedback.save!
end
feedback_for_post = Feedback.all