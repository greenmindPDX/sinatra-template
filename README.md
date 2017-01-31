## Sinatra Store ##
The goal of this project is to create a simple Sinatra app that can run under Docker with JRuby

It is be a proof-of-concept for using Sinatra to create lightweight Ruby microservices. Using JRuby to fit into the HSQ infrastructure.

## To Install ##

`rvm install jruby-9.0.3.0`

`jruby -S bundle install`



## FAQ ##
Q. how to manage migrations?

Run rake -T to see available tasks. Example is : rake db:create_migration NAME=create_orders

Q. what is tux?

A. the tux gem is a very lightlweight equivalent to the rails console

Q. How do you whitelist params?

A. we need a helper to do that in app.rb

Q. How do you start the server?

A. `bundle exec jruby app.rb` and go to http://localhost:4567/orders

## Deployment ##
