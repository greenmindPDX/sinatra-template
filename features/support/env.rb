# Generated by cucumber-sinatra. (2017-02-14 22:11:26 +0000)
require "rack/test"
ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', '..', 'app/app.rb')


module KnowsAboutTheStoreApp
  def app
    StoreApp.new
  end
end

World(KnowsAboutTheStoreApp, Rack::Test::Methods)
