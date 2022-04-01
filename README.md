# README

#### Instructions

* Clone repo from https://github.com/mayankkumarji/social-media-client-test
* Please make sure that you have installed the proper ruby (2.7.0), I have not test above 2.7.0
* Run the command `bundle install` to install the required gems, Gemfile.lock is also there 
* Add database credentials and rename `database.example` with `database.yml`
* You can check all the Rake tasks using rake -T commands, use rake db:create, rake db:migrate and rake db:seed commands for DB Create, migration and seed respectivaly 
* rake db:seed may take a long time as it pumps up the huge data
* Start the server using `rackup`
* Visit `localhost:9292/login` on postman or `curl localhost:9292/login`
* Run the tests `bundle exec rspec` and run server on different terminal with `rackup` altogether
* Run cronjob with `bundle exec whenever`

#### Description

* Th project is a social media app for JSON API service in Ruby without using Ruby on Rails
* Used `ActiveRecord` ORM with Postgresql database
* Used `roda` gem for the routing feature
* Added Test cases to validate all the API's in the `spec` directory

#### Future Scope

* Add `bcrypt` gem to add password security feature while login
* Add more modules to separate controller and model based methods

#### API End points

* For login 
  - url: `http://localhost:9292/login`
  - body: { username: 'admin', password: 'pass' }
  