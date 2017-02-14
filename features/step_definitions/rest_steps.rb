require 'rack/test'
World(Rack::Test::Methods)

Given( /^I send and accept JSON$/ )do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
end

When(/^I send a GET request for "([^"]*)"$/) do |path|
  get path
end

Then(/^the response should be "([^\"]*)"$/) do |status|
  expect( last_response.status ).to eq status.to_i
end

Then( /^the JSON response should be an array with (\d+) "([^\"]*)" elements$/ )do |number_of_children, type_name|
  page = JSON.parse(last_response.body)
  data = page["data"]
  raise "response did not contain data" if data.blank?
  expect( data.select { |d| d["type"] == type_name.pluralize }.length ).to eq number_of_children.to_i
end
