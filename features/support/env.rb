# Generated by cucumber-sinatra. (2014-05-08 12:37:12 +0100)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', './server.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Bookmark

class BookmarkWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  BookmarkWorld.new
end
