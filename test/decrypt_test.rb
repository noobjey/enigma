require 'minitest/autorun'
require 'minitest/pride'
require 'date'
require './lib/decrypt'

class DecryptTest < Minitest::Test
  def test_decrypt_converts_date_to_ddmmyy
    decryptor = Decrypt.new
    today     = Date.today
    expected  = today.strftime("%d%m%y")

    result = decryptor.date_to today

    assert_equal expected, result
  end

  def test_decrypt_squares_date
    decryptor = Decrypt.new
    date      = '010115'
    expected  = 102313225

    result = decryptor.square date

    assert_equal expected, result
  end

  def test_decrypt_pulls_date_offset
    decryptor   = Decrypt.new
    date_offset = 102313225
    expected    = '3225'

    result = decryptor.date_offset date_offset

    assert_equal expected, result
  end

  def test_decrypt_has_date_offset
    decryptor = Decrypt.new
    date      = Date.new(2015, 1, 1)

    expected = { a: 3, b: 2, c: 2, d: 5 }

    decryptor.decrypt date
    result = decryptor.date_offsets

    assert_equal expected, result
  end

  def test_decrypt_has_key_offset
    decryptor = Decrypt.new
    date      = Date.today
    key       = 41521
    expected  = { a: 41, b: 15, c: 52, d: 21 }

    decryptor.decrypt date, key
    result = decryptor.key_offsets

    assert_equal expected, result
  end

  def test_decrypt_adds_key_and_date_offsets
    decryptor = Decrypt.new
    date      = Date.new(2015, 1, 1)
    key       = 41521
    expected  = { a: 44, b: 17, c: 54, d: 26 }

    decryptor.decrypt date, key
    result = decryptor.total_offsets

    assert_equal expected, result
  end

  def test_decrypt_rotates_when_small_offset
    decryptor = Decrypt.new
    expected  = 'a'
    character = 'f'
    offset = 5

    result = decryptor.rotate character, offset

    assert_equal expected, result
  end

  def test_decrypt_rotates_when_large_offset
    decryptor = Decrypt.new
    expected  = 'p'
    character = 'a'
    offset = 63

    result = decryptor.rotate character, offset


    assert_equal expected, result
  end

  def test_decrypt_uses_offset
    decryptor = Decrypt.new
    date      = Date.new(2015, 1, 1)
    key       = 41521
    message = 'frp0'
    expected  = 'aaaa'

    result = decryptor.decrypt date, key, message


    assert_equal expected, result
  end

  def test_decrypt_reuses_offsets_when_more_than_four
    decryptor = Decrypt.new
    date      = Date.new(2015, 1, 1)
    key       = 41521
    message  = 'frp0frp0f'
    expected = 'aaaaaaaaa'

    result = decryptor.decrypt date, key, message


    assert_equal expected, result
  end

  def test_decrypt_keeps_non_decryptable_characters
    decryptor = Decrypt.new
    date      = Date.new(2015, 1, 1)
    key       = 41521
    message  = 'frp0!rp0f'
    expected = 'aaaa!aaaa'

    result = decryptor.decrypt date, key, message


    assert_equal expected, result
  end
end
