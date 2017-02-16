ENV['RACK_ENV'] = 'test'
require 'sinatra'
require 'sinatra/activerecord'
require_relative '../lib/models/order'
