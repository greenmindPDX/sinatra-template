## Sinatra Jruby Template ##

this is a template app for using Sinatra to create lightweight Ruby microservices. Using JRuby. Mostly this is meant to run with Docker containers. The Sinatra part because you really don't need Rails to run a simple JSON api, and JRuby
because sometimes you work for weird folks. Not judging.

Also, I wouldn't ever really write Cucumber tests in this manner, since they are overly technical and not for PMs,
but there you have it.

## To Install (local) ##

`rvm install jruby-9.0.3.0`

`jruby -S bundle install`

`rackup`

** NOTE: all jruby commands are used with `-S` to use $PATH **

## Running with Docker ##

Build the containers: `docker-compose build`

Launch the containers: `docker-compose up`

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

A. Sinatra is extremely lightweight. Routing is done through app.rb. Mostly autoloading doesn't work as expected, so you have to do a lot of `require_relative.` Also, JRuby oddnesses.es.


