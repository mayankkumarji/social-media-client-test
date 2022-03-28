# frozen_string_literal: true

class Rating < ActiveRecord::Base
  validates :rate, presence: true, inclusion: { in: 1..5 }

  belongs_to :post

  # Add rating to a post
  def self.create_rating(params: nil, post: nil)
    post = Post.find_by(id: post)
    return { status: 500, message: 'Post not found!' } if post.blank?

    rating = post.ratings.build(params['rating'])
    if rating.save
      rating_average = rating_average(post)
      { data: rating, average_rating: rating_average, status: 200, message: 'Rating created successfully!' }
    else
      { status: 422, message: 'Failed to create rating!' }
    end
  end

  # Calculate average rating for the post
  def self.rating_average(post)
    post.ratings.map(&:rate).sum / post.ratings.size.to_f
  end
end
