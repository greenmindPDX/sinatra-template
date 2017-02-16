## Sinatra Store ##
The goal of this project is to create a simple Sinatra app that can run under Docker with JRuby. The app connects to PostGres with activerecord-jdbc-adapter. In docker-compose, Jruby/Sinatra container gets built first, then the PostGreSQL container.

It is be a proof-of-concept for using Sinatra to create lightweight Ruby microservices. Using JRuby to fit into the HSQ infrastructure. Mostly this is meant to run with Docker containers.

## To Install (local) ##

`rvm install jruby-9.0.3.0`

`jruby -S bundle install`

** NOTE: all jruby commands are used with `-S` to use $PATH **

## Running with Docker ##

Build the containers: `docker-compose build`

Launch the containers: `docker-compose up`

Verify a non-db related endpoint is available: `http://localhost:3000/sup`

Testing Ruby: `docker-compose run api jruby -S rake -T`

Setting up/Seeding the DB:

`docker-compose run api jruby -S rake db:create db:migrate db:seed`

Starting the app:

`docker-compose up`

Once the container is running in the background, you should be able to cURL a sample endpoint that fetches data.

`curl http://localhost:3000/orders`

Running Tests:

`docker-compose run api jruby -S rspec`

## FAQ ##

Q. how to manage migrations?

Run rake -T to see available tasks. Example is: `rake db:create_migration NAME=create_orders`

Q. what is tux?

A. the tux gem is a very lightweight equivalent to the rails console.

Example:

```
bash-4.3# jruby -S tux
Loading development environment (Rack 1.3)
>> Order.count
D, [2017-02-10T00:04:10.389000 #7] DEBUG -- :    (59.0ms)  SELECT version()
D, [2017-02-10T00:04:10.536000 #7] DEBUG -- :    (1.0ms)  SELECT COUNT(*) FROM "orders"
=> 50
>>
```

Q. How do you whitelist params?

A. we need a helper to do that in app.rb

Q. How do you start the server?

A. Start it in Docker.

Q. Why doesn't [fill in your favorite Rails thing] work?

A. Sinatra is extremely lightweight. Routing is done through app.rb. Mostly autoloading doesn't work as expected, so you have to do a lot of `require_relative.` We are also a little limited because of some of JRuby's oddness

## TODOs ##

Add cuke tests

## TESTING (so far) ##
Spin up an instance with bash, then `docker-compose run -e 'ENV=test' jruby -S rake db:setup`

Then run the test suite with `docker-compose run -e 'ENV=test' api jruby -S rspec spec/`

## Troubleshooting ##

1. If you need to attach to the api container, `docker-compose run api bash.`

2. You might have binding problems if you are running postgres locally With Homebrew. On OSX, `brew services stop postgres`.


## Deployment ##

 merp
