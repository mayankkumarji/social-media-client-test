# frozen_string_literal: true

require 'active_record'
require 'byebug'
require_relative './models/user'
require_relative './models/post'
require_relative './models/rating'
require_relative './models/feedback'

# Database connection
def db_configuration
  db_configuration_file = File.join(File.expand_path(__dir__), '..', 'db', 'database.yml')
  YAML.safe_load(File.read(db_configuration_file), aliases: true)
end
ActiveRecord::Base.establish_connection(db_configuration['development'])
