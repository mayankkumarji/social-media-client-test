# frozen_string_literal: true

class Feedback < ActiveRecord::Base
  validates :comment, presence: true

  belongs_to :user
  belongs_to :post

  def self.create_feedback(params: nil, post: nil)
    post = Post.find_by(id: post)
    return { status: 500, message: 'Post not found!' } if post.blank?

    feedback = post.feedbacks.build(params['feedback'])
    if feedback.save
      feedback_list = feedback.feedback_list_by_user(params['feedback']['user_id'])
      { data: feedback, feedback_list: feedback_list, status: 200, message: 'Feedback created successfully!' }
    else
      { status: 422, message: 'Failed to create feedback!' }
    end
  end

  def feedback_list_by_user(user_id)
    post.feedbacks.map { |feedback| feedback if feedback.user_id == user_id }.compact
  end
end
