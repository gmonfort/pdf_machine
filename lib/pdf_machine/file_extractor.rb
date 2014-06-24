require "httparty"
require "nokogiri"

module PDFMachine
  class FileExtractor
    attr_reader :svg, :data

    def initialize(svg_file)
      @svg  = svg_file
    end

    def fetch_remote_files
      begin
        f = File.open(svg)
        @data = Nokogiri::XML(f)
        images = (@data / "image")

        images.each do |image|
          url = image.attribute("href").value
          filename = File.basename(url)
          filename.gsub!(/[^a-zA-Z0-9\.-_]*/, "")

          local_path = "/tmp/#{filename}"
          File.open(local_path, "wb") do |f| 
            f.write HTTParty.get(url).parsed_response
          end

          image.attribute('href').value = "file://#{local_path}"
        end

      rescue => e
        puts "Error: #{e.inspect}"
      ensure
        f.close if f
      end

      File.open(svg, 'w') do |f|
        f << @data.to_xml
      end

      svg
    end
  end
end

# svg = ARGV[0]
# fe = PDFMachine::FileExtractor.new svg
# fe.fetch_remote_files
