require 'minitest/autorun'
require 'minitest/pride'
require './lib/runner'

class RunnerTest < Minitest::Test

  def test_runner_reads_input
    message = 'message.txt'

    runner = Runner.new
    runner.encrypt message

    result = runner.message

    assert_equal message, result
  end

end
