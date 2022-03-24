# frozen_string_literal: true

class Feedback < ActiveRecord::Base
  validates :comment, presence: true

  belongs_to :users
  belongs_to :post
end
