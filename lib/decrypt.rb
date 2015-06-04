require_relative 'runner'

# ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 030415
input_file = ARGV[0]
output_file = ARGV[1]
key = ARGV[2]
date = ARGV[3]

runner = Runner.new input_file, output_file, key, date

runner.decrypt
