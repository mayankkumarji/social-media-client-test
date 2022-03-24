# frozen_string_literal: true

class Post < ActiveRecord::Base
  validates :title, :content, presence: true

  belongs_to :users
  has_many :ratings
end
