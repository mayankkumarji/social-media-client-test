# frozen_string_literal: true

class Rating < ActiveRecord::Base
  validates :rate, presence: true, inclusion: { in: 1..5 }

  belongs_to :posts
end
