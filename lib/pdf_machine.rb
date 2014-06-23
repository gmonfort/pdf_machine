require "pdf_machine/config"
require "pdf_machine/processor"
require "pdf_machine/batik_processor"

module PDFMachine
  class PDFMachineError < StandardError; end
  class CairoError < PDFMachineError; end
  class UnsupportedFormatError < PDFMachineError; end
  class FileNotFoundError < PDFMachineError; end
  class InvalidSvgFileError < PDFMachineError; end

  class << self
    attr_accessor :config
  end

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
  end

  def self.convert_svg(svg, output_format, options={})
    options   = config.to_hash.merge!(options)
    processor = Processor.new(svg, output_format, options)

    processor.process
  end

  def self.convert_svg_using_batik(svg, output_format, options={})
    options   = config.to_hash.merge!(options)
    processor = BatikProcessor.new(svg, output_format, options)

    processor.process
  end
end
