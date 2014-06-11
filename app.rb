require "cuba"
require "rack/protection"

Cuba.use Rack::Session::Cookie, :secret => "9461c163cbc13617358e50fdbd24ec7fd0ab1e099ee7ee121a0237e0d98047b0b8b23fb806dc2bcfa697d75c383d46c92a79c5d948578ae34eb0487db30a8120"
Cuba.use Rack::Protection
Cuba.use Rack::Protection::RemoteReferrer

if ENV["RACK_ENV"] == "production"
  Cuba.use Rack::SSL
end

Cuba.define do
  on get do
    # on "admin" do
    #   run Admin
    # end

    on "form" do
      res.write "Hello world!"
      # res.write view("home", content: "hello, world")
    end

    on root do
      res.redirect "/form"
    end
  end
end
