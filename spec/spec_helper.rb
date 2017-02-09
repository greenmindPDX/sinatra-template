ENV['RACK_ENV'] = 'test'
require 'sinatra'
require 'sinatra/activerecord'
require_relative '../app/models/order'
