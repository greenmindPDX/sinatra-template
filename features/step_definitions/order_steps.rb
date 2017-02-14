ENV['RACK_ENV'] = 'test'
require 'sinatra'
require 'sinatra/activerecord'
require_relative '../../app/models/order'

Given(/^the orders:$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  columns = table.headers.map(&:downcase)
  table.rows.each do |row|
    Order.create( columns.zip( row ).to_h )
  end
end
