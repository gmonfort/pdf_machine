require "cuba"
require "cuba/render"
require 'cuba/send_file'
require "rack/protection"
require "tilt/erb"
require "pdf_machine"

Cuba.use Rack::Session::Cookie, :secret => "9461c163cbc13617358e50fdbd24ec7fd0ab1e099ee7ee121a0237e0d98047b0b8b23fb806dc2bcfa697d75c383d46c92a79c5d948578ae34eb0487db30a8120"
Cuba.use Rack::Protection
Cuba.use Rack::Protection::RemoteReferrer

Cuba.plugin Cuba::Render
Cuba.plugin Cuba::SendFile

Cuba.define do
  on root do
    res.redirect "/pdfs"
  end

  on get, "pdfs" do
    res.write view('pdfs/form')
  end

  on post, "pdfs", param("svg") do |svg_data|
    begin
      file = svg_data[:tempfile].path
      blob = PDFMachine.convert_svg(file, :pdf)

      res.headers['Content-Type'] = 'application/pdf'
      res.headers['Content-Disposition'] = 'attachment; filename="out.pdf"'

      send_file(blob.path)
    rescue => e
      puts "****** ERROR --- #{e.inspect}"
      res.redirect "/pdfs"
    end
  end

  on post, "pngs", param("svg") do |svg_data|
    begin
      file = svg_data[:tempfile].path
      blob = PDFMachine.convert_svg(file, :png)

      res.headers['Content-Type'] = 'image/png'
      res.headers['Content-Disposition'] = 'attachment; filename="out.pdf"'

      send_file(blob.path)
    rescue => e
      puts "****** ERROR --- #{e.inspect}"
      res.redirect "/pngs"
    end
  end
end
