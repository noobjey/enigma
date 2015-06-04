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
    @message = File.read file_name
  end

  def encrypt
    File.write @output_filename,
               Encryptor.new.encrypt(@date, @key, @message)
    confirmation_message
  end

  def decrypt
    File.write @output_filename,
               Decryptor.new.decrypt(@date, @key, @message)
    confirmation_message
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
