require 'minitest/autorun'
require 'minitest/pride'
require './lib/runner'

class RunnerTest < Minitest::Test

  def test_runner_reads_input
    message_file = 'message.txt'
    output_file = 'output.txt'
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
    output_file = 'output.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file << 'a'
    input_file.close

    runner = Runner.new message_file, output_file, key, date
    runner.encrypt

    output = File.open output_file, 'r'

    assert_equal 'f', output.readchar
    output.close
  end



  def test_runner_encrypts_one_character_message
    # skip
    message_file = 'message.txt'
    output_file = 'output.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file << 'a'
    input_file.close

    runner = Runner.new message_file, output_file, key, date
    runner.encrypt

    output_file = File.open output_file, 'r'

    result = output_file.readlines[0]
    output_file.close

    assert_equal 'f', result
  end

  def test_runner_encrypts_multi_character_message
    # skip
    message_file = 'message.txt'
    output_file = 'output.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file.write 'a aaaa'
    input_file.close

    runner = Runner.new message_file, output_file, key, date
    runner.encrypt

    output_file = File.open output_file, 'r'

    result = output_file.readlines[0]
    output_file.close

    assert_equal 'fop0fr', result
  end

  def test_runner_returns_what_it_did
    message_file = 'message.txt'
    output_file = 'output.txt'
    date = Date.new(2015, 1, 1)
    key = 41521
    expected = "Created 'output.txt' with the key 41521 and date 01012015"

    input_file = File.open message_file, 'w+'
    input_file.write 'a aaaa'
    input_file.close

    runner = Runner.new message_file, output_file, key, date
    runner.encrypt

    result = runner.confirmation_message

    assert_equal expected, result
  end

  def test_runner_decrypts_one_character_message
    # skip
    message_file = 'message.txt'
    output_file = 'output.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file << 'f'
    input_file.close

    runner = Runner.new message_file, output_file, key, date
    runner.decrypt

    output_file = File.open output_file, 'r'

    result = output_file.readlines[0]
    output_file.close

    assert_equal 'a', result
  end

  def test_runner_encrypts_multi_character_message
    # skip
    message_file = 'message.txt'
    output_file = 'output.txt'
    date = Date.new(2015, 1, 1)
    key = 41521

    input_file = File.open message_file, 'w+'
    input_file.write 'fop0fr'
    input_file.close

    runner = Runner.new message_file, output_file, key, date
    runner.decrypt

    output_file = File.open output_file, 'r'

    result = output_file.readlines[0]
    output_file.close

    assert_equal 'a aaaa', result
  end
end
