require_relative '../../api_helper'
require 'test/unit/assertions'
include Test::Unit::Assertions

Given(/^I have a validation token$/) do
    @ah = ApiHelper.new
    @token = @ah.token
end

Then(/^I get the return code (.*) and (.*)$/) do |code, elements|
  assert_equal(code, @ah.return_code.to_s)
  assert_equal(elements, @ah.num_elements.to_s)
  # puts "The function is: #{@ah.func}, the query is #{@ah.query}, the sort option is #{@ah.sort}, the limit is #{@ah.limit}, the return code: #{@ah.return_code} and number of elements is: #{@ah.num_elements}"
end


When(/^I call the search API$/) do
  @ah.run_search
end

And(/^the query parameter is (.*)$/) do |query|
  if query != ""
    @ah.query = query
    query.gsub!("\"", "")
  end
end

And(/^the sort parameter is "([^"]*)"$/) do |sort|
  if sort != ""
    sort.gsub!("\"", "")
    @ah.sort = sort
  end
end

And(/^the limit parameter is (.*)$/) do |limit|
  if limit != ""
    # limit.gsub!("\"", "")
    @ah.limit = limit
  end
end

And(/^the function is GET$/) do
  @ah.func = 'get'
  # query.gsub!("\"", "")
end

And(/^the function is HEAD$/) do
  @ah.func = "head"
end


And(/^the asset parameter is (.*)$/) do |asset_id|
  @ah.asset_id = asset_id
end

When(/^I call the asset API$/) do
  @ah.run_asset
end

Then(/^I get the asset return code (.*) and (.*)$/) do |code, assets|
  assert_equal(code, @ah.return_code.to_s)
  assert_equal(assets, @ah.num_elements.to_s)
  if (@ah.asset_id != "" and @ah.func == "get")# case where the asset id is specified.
    assert_equal(@ah.asset_id.to_s, @ah.asset_id_retrieved.to_s)
  end
end