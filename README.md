The goal of this project is to create a simple Sinatra app that can run under Docker with JRuby

It will be a proof-of-concept for using Sinatra to create Ruby microservices

#To Install#
$rvm install jruby-9.0.3.0
$jruby -S bundle install

$rake -T # will show you tasks
$jruby -S bundle exec jruby app.rb

Fire up your browser and view http://localhost:4567/ 
