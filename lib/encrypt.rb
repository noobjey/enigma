require_relative 'runner'

input_file = ARGV[0]
output_file = ARGV[1]

runner = Runner.new input_file, output_file

runner.encrypt
