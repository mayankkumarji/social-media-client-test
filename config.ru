require 'roda'
require './app/main'

class App < Roda
  route do |r|
    # GET /login request
    r.get 'login' do
      username = r.params['username']
      password = r.params['password']
      authenticate = User.authentication(username: username, password: password)
      authenticate.to_json
    end
  end
end

run App.freeze.app
