current_dir = File.dirname(File.realpath(__FILE__))
$LOAD_PATH << current_dir << File.join(current_dir, "lib")

ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.setup(:default, ENV["RACK_ENV"])

require "./app"

use Rack::Auth::Basic, "Please authenticate" do |username, password|
  username == "german" && password == "pdf_machine"
end

run Cuba
