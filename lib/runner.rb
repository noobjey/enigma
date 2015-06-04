require_relative 'encryptor'
require_relative 'decryptor'
require 'date'
require_relative 'key_generator'

class Runner
  attr_reader :date, :key

  def initialize input_filename = '', output_filename = '', date = Date.today, key = KeyGenerator.new.key
    @input_filename = input_filename
    @output_filename = output_filename
    @date = date
    @key = key
    @message = read_message @input_filename
  end

  def read_message file_name
    file = File.open file_name, 'r'
    message = ''
    file.each_char do |char|
      message << char
    end
    file.close
    @message = message
  end

  def encrypt
    encryptor = Encryptor.new
    encrypted_message = encryptor.encrypt @date, @key, @message

    write_output(encrypted_message, @output_filename)

    puts confirmation_message
  end

  def decrypt
    decryptor = Decryptor.new
    decrypted_message = decryptor.decrypt @date, @key, @message

    write_output(decrypted_message, @output_filename)
    puts confirmation_message
  end

  def write_output(encrypted_message, output)
    output_file = File.new output, 'w+'
    output_file << encrypted_message
    output_file.close
  end


  def confirmation_message
    if @date.is_a? Date
      date = @date.strftime("%d%m%Y")
    else
      date = @date
    end

    "Created '#{@output_filename}' with the key #{@key} and date #{date}"
  end
end
