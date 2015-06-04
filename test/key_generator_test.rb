require 'minitest/autorun'
require 'minitest/pride'
require './lib/key_generator'

class KeyGeneratorTest < Minitest::Test
  def test_key_defaults_to_41521
    key_generator = KeyGenerator.new
    expected  = 41521

    result = key_generator.default

    assert_equal expected, result
  end

  def test_key_generates_five_numbers
    key_generator = KeyGenerator.new
    expected  = 5

    result = key_generator.key

    assert_equal expected, result.to_s.rjust(5,'0').length
  end
end
