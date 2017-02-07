## Sinatra Store ##
The goal of this project is to create a simple Sinatra app that can run under Docker with JRuby

It is be a proof-of-concept for using Sinatra to create lightweight Ruby microservices. Using JRuby to fit into the HSQ infrastructure.

## To Install (local) ##

`rvm install jruby-9.0.3.0`

`jruby -S bundle install`

## FAQ ##

Q. how to manage migrations?

Run rake -T to see available tasks. Example is : rake db:create_migration NAME=create_orders

Q. what is tux?

A. the tux gem is a very lightweight equivalent to the rails console

Q. How do you whitelist params?

A. we need a helper to do that in app.rb

Q. How do you start the server?

A. `bundle exec jruby app.rb` and go to http://localhost:4567/orders. Or create a docker container

## TODO ##

1. PostgreSQL is not tuned right now for production.

## Running with D0kker ##

Building the containers: `docker-compose build .`

Launching the containers: `docker-compose up`

Verify a non-db related endpoint is available: `http://localhost:3000/sup`


Testing Ruby: `docker-compose run web jruby -S rake -T`

Setting up/Seeding the DB:

`docker-compose run api jruby -S rake db:create db:migrate db:seed`


Once the container is running in the background, you should be able to cURL a sample endpoint

`curl http://0.0.0.0:7080/sup`


Then to shut down the container, docker stop {container_name}
## Deployment ##
