require 'minitest/autorun'
require 'minitest/pride'
require './lib/key_generator'

class KeyGeneratorTest < Minitest::Test
  def test_key_defaults_to_41521
    assert_equal 41521, KeyGenerator.new.default
  end

  def test_key_generates_five_numbers
    key_generator = KeyGenerator.new
    expected  = 5

    result = key_generator.key

    assert_equal expected, result.to_s.rjust(5,'0').length
  end
end
