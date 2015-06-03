require 'minitest/autorun'
require 'minitest/pride'
require 'date'
require './lib/encrypt'

class EncryptTest < Minitest::Test
  def test_encrypt_converts_date_to_ddmmyy
    encryptor = Encrypt.new
    today     = Date.today
    expected  = today.strftime("%d%m%y")

    result = encryptor.date_to today

    assert_equal expected, result
  end

  def test_encrypt_squares_date
    encryptor = Encrypt.new
    date      = '010115'
    expected  = 102313225

    result = encryptor.square date

    assert_equal expected, result
  end

  def test_encrypt_pulls_date_offset
    encryptor   = Encrypt.new
    date_offset = 102313225
    expected    = '3225'

    result = encryptor.date_offset date_offset

    assert_equal expected, result
  end

  def test_encrypt_has_date_offset
    encryptor = Encrypt.new
    date      = Date.new(2015, 1, 1)

    expected = { a: 3, b: 2, c: 2, d: 5 }

    encryptor.encrypt date
    result = encryptor.date_offsets

    assert_equal expected, result
  end

  def test_encrypt_has_key_offset
    encryptor = Encrypt.new
    date      = Date.today
    key       = 41521
    expected  = { a: 41, b: 15, c: 52, d: 21 }

    encryptor.encrypt date, key
    result = encryptor.key_offsets

    assert_equal expected, result
  end

  #don't know how to test this way im doing it gives false positives
  # def test_encrypt_date_key_defaults_to_today
  #   encryptor = Encrypt.new
  #   date      = Date.today
  #
  #   encryptor.encrypt date
  #   expected = encryptor.date_offsets
  #
  #   encryptor.encrypt
  #   result = encryptor.date_offsets
  #
  #   assert_equal expected, result
  # end
  #

  #   def test_encrypt_key_defaults_to_41521
  #     encryptor = Encrypt.new
  #     date      = Date.today
  #     key = 41521
  #
  #     encryptor.encrypt date, key
  #     expected = encryptor.key_offsets
  # puts "******expected before #{expected} ***********"
  #     encryptor.encrypt
  # puts "******expected after #{expected} ***********"
  #     # require 'pry'; binding.pry
  #     result = encryptor.key_offsets
  #     assert_equal expected, result
  #   end

end
