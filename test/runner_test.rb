require 'minitest/autorun'
require 'minitest/pride'
require './lib/runner'
require './lib/key_generator'

class RunnerTest < Minitest::Test

  def test_runner_reads_input
    # skip
    message_file = 'message.txt'
    output_file = 'encrypted.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file << 'a'
    input_file.close

    runner = Runner.new message_file, output_file, key, date

    result = runner.read_message message_file
    assert_equal 'a', result.strip

  end

  def test_runner_outputs_to_file
    # skip
    message_file = 'message.txt'
    output_file = 'encrypted.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file << 'a'
    input_file.close

    runner = Runner.new message_file, output_file, date, key
    runner.encrypt

    output = File.open output_file, 'r'

    assert_equal 'c', output.readchar
    output.close
  end

  def test_runner_encrypt_defaults_to_random_key
    # skip
    message_file = 'message.txt'
    output_file = 'encrypted.txt'
    date = Date.new(2015, 1, 1)

    runner = Runner.new message_file, output_file, date
    runner.encrypt
    first_key = runner.key

    runner2 = Runner.new message_file, output_file, date
    runner2.encrypt
    second_key = runner2.key
# require 'pry'; binding.pry
    refute first_key.eql? second_key
  end

  def test_runner_encrypts_one_character_message
    # skip
    message_file = 'message.txt'
    output_file = 'encrypted.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file << 'a'
    input_file.close

    runner = Runner.new message_file, output_file, date, key
    runner.encrypt

    output_file = File.open output_file, 'r'

    result = output_file.readlines[0]
    output_file.close

    assert_equal 'c', result
  end

  def test_runner_encrypts_multi_character_message
    # skip
    message_file = 'message.txt'
    output_file = 'encrypted.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file.write 'a aaaa'
    input_file.close

    runner = Runner.new message_file, output_file, date, key
    runner.encrypt

    output_file = File.open output_file, 'r'

    result = output_file.readlines[0]
    output_file.close

    assert_equal 'cop0cr', result
  end

  def test_runner_returns_what_it_did_for_decrypt
    # skip
    message_file = 'message.txt'
    output_file = 'decrypted.txt'
    date = '01012015'
    key = 41521
    expected = "Created 'decrypted.txt' with the key 41521 and date 01012015"

    input_file = File.open message_file, 'w+'
    input_file.write 'a aaaa'
    input_file.close

    runner = Runner.new message_file, output_file, date, key
    runner.decrypt

    result = runner.confirmation_message

    assert_equal expected, result
  end

  def test_runner_returns_what_it_did_for_encrypt
    # skip
    message_file = 'message.txt'
    output_file = 'encrypted.txt'
    date = Date.new(2015, 1, 1)
    key = 41521
    expected = "Created 'encrypted.txt' with the key 41521 and date 01012015"

    input_file = File.open message_file, 'w+'
    input_file.write 'a aaaa'
    input_file.close

    runner = Runner.new message_file, output_file, date, key
    runner.decrypt

    result = runner.confirmation_message

    assert_equal expected, result
  end

  def test_runner_decrypts_one_character_message
    # skip
    message_file = 'message.txt'
    output_file = 'decrypted.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file << 'f'
    input_file.close

    runner = Runner.new message_file, output_file, date, key
    runner.decrypt

    output_file = File.open output_file, 'r'

    result = output_file.readlines[0]
    output_file.close

    assert_equal 'd', result
  end

  def test_runner_decrypts_multi_character_message
    # skip
    message_file = 'message.txt'
    output_file = 'decrypted.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file.write 'fop0fr'
    input_file.close

    runner = Runner.new message_file, output_file, date, key
    runner.decrypt

    output_file = File.open output_file, 'r'

    result = output_file.readlines[0]
    output_file.close

    assert_equal 'd aada', result
  end
end
