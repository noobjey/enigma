require 'minitest/autorun'
require 'minitest/pride'
require './lib/runner'

class RunnerTest < Minitest::Test

  def test_runner_reads_input
    message_file = 'message.txt'
    output_file = 'output.txt'

    runner = Runner.new
    runner.encrypt message_file, output_file

    result = runner.message
    assert_equal message_file, result

    result = runner.output
    assert_equal output_file, result
  end

  def test_runner_outputs_to_file
    message_file = 'message.txt'
    output_file = 'output.txt'

    runner = Runner.new
    runner.encrypt message_file, output_file

    result = runner.output
    assert_equal output_file, result

    output = File.open output_file, 'r'

    # cant get readable to work
    # assert output.readable?
    assert output.size > 0
    output.close
  end

  def test_runner_encrypts_one_character_message
    message_file = 'message.txt'
    output_file = 'output.txt'

    input_file = File.open message_file, 'w+'
    input_file << 't'
    input_file.close

    runner = Runner.new
    runner.encrypt message_file, output_file

    output_file = File.open output_file, 'r'

    result = output_file.readlines[0]
    output_file.close

    assert_equal '3', result
  end

end
