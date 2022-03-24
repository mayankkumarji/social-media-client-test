require 'roda'
require './app/main'

class App < Roda
  route do |r|
    # GET /login request
    r.get 'login' do
    end
  end
end

run App.freeze.app
