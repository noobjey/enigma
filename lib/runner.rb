require_relative 'encrypt'
require 'date'

class Runner
  def initialize input_filename = '', output_filename = '', key = 41521, date = Date.today
    @input_filename = input_filename
    @output_filename = output_filename
    @date = date
    @key = key
    @message = ''
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
    @message = read_message @input_filename
    encryptor = Encrypt.new
    encrypted_message = encryptor.encrypt @date, @key, @message

    write_output(encrypted_message, @output_filename)
    confirmation_message
  end

  def write_output(encrypted_message, output)
    output_file = File.new output, 'w+'
    output_file << encrypted_message
    output_file.close
  end


  def confirmation_message
    "Created '#{@output_filename}' with the key #{@key} and date #{@date.strftime("%d%m%Y")}"
  end
end
