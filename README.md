# README

#### Instructions

* Clone repo
* Run the command `bundle install` to install the required gems
* Add database credentials and rename `database.example` with `database.yml`
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
