def print_message(outstream)
  outstream.puts "omg"
end

# global print (ie runner file)
puts "Example 1:"
outstream = $stdout
print_message outstream

# for tests
require 'stringio'
fake_output = StringIO.new
print_message fake_output
puts "Example 2:"
puts "  fake output is: #{fake_output.string.inspect}"
puts '  should be: "omg"'

# Do I want to record it?
File.open("output", "w") do |file|
  print_message file
end
