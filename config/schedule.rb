# frozen_string_literal: true

require 'axlsx'
require_relative '../app/main'

every :day, at: '09:00am' do
  p = Axlsx::Package.new
  p.workbook.add_worksheet(name: 'Feedback') do |sheet|
    sheet.add_row [
      'Id',
      'comment',
      'User',
      'Post',
      'Owner'
    ]
    Feedback.all.each do |feedback|
      next if feedback.id.nil?

      sheet.add_row [
        feedback.id,
        feedback.comment,
        feedback.user_id,
        feedback.post_id,
        feedback.owner_id
      ]
    end
  end
  p.use_shared_strings = true
  file = File.new("./#{Time.now}.xlsx", 'w')
  p.serialize file
end
