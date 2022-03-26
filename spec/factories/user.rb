require 'factory_bot'
# require_relative '../../app/models/user'
FactoryBot.define do
  factory :user, class: 'User' do
    username { 'admin' }
    password { 'pass' }
  end
end
