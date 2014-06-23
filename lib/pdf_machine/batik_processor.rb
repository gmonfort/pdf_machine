module PDFMachine
  class BatikProcessor
    attr_reader :svg

    def initialize(input, output_format, options)
      @svg      = input
      @format   = output_format.to_sym
      @options  = options
    end

    def process
      # puts "Batik command: #{batik_command}"

      system(batik_command)
      File.new(output_file)
    end

    private

    def batik_command
      command =   ["java -cp #{classpath} #{java_wrapper_class}"]
      command <<  "#{svg}"
      command <<  "#{output_file}"
      command.join(' ')
    end

    def java_wrapper_class
      "Converter"
    end

    def output_file
      # @options[:output_file]
      "output.pdf"
    end

    def working_dir
      # "/Users/german/Downloads/batik-1.7"
      "/home/deploy/src/batik-1.7"
    end

    def classpath
      ["#{working_dir}/build", "#{working_dir}/batik-rasterizer.jar"].join(":")
    end
  end
end
