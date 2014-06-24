require "test_helper"
require "pdf_machine"
require "minitest/autorun"

class ConversionTest < MiniTest::Test

  def test_works
    result = PDFMachine.convert_svg(svg, :pdf, options)
    assert_instance_of File, result
    assert_operator result.size, :>, 0
  end

  private

  def svg
    # "test/fixtures/real_sample1.svg"
    "test/fixtures/baby.svg"
  end

  def options
    {
      output_file: "./test/out.pdf"
    }
  end
end
