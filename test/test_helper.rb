$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

ENV["RACK_ENV"] ||= "test"
require "minitest/autorun"
require_relative "../app"

Dir["test/support/**/*.rb"].each { |file| require file }
