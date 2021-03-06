class Encryptor
  attr_reader :date_offsets, :key_offsets, :total_offsets

  def initialize
    @date_offsets  = { a: 0, b: 0, c: 0, d: 0 }
    @key_offsets   = { a: 0, b: 0, c: 0, d: 0 }
    @total_offsets = { a: 0, b: 0, c: 0, d: 0 }
  end

  def date_to date
    date.strftime("%d%m%Y")
  end

  def square date
    date.to_i**2
  end

  def date_offset number
    offset = number.to_s
    offset.slice offset.length - 4, offset.length
  end

  def rotate character, offset
    character_map = 'abcdefghijklmnopqrstuvwxyz0123456789 .,'.chars

    start_position = character_map.find_index character

    the_rotate = (offset + start_position) % character_map.length
    character_map[the_rotate]
  end

  def encrypt(date = Date.new(2015, 1, 1), key = 41521, message = '')
    calculate_date_offset(date)

    calculate_key_offset(key)

    calculate_total_offset



    encrypted_message = ''
    message.chars.each_with_index do |character, index|
      if encryptable_character character
        key = offset_key_to_use(index)

        encrypted_character = rotate character, @total_offsets[key].to_i
        encrypted_message << encrypted_character
      else
        encrypted_message << character
      end
    end
    encrypted_message
  end

  def offset_key_to_use(index)
    key_value = index % 4

    if key_value == 0
      key = :a
    elsif key_value == 1
      key = :b
    elsif key_value == 2
      key = :c
    else
      key = :d
    end
    key
  end

  def calculate_total_offset
    @total_offsets.merge!(@date_offsets) { |key, oldval, newval| oldval + newval }
    @total_offsets.merge!(@key_offsets) { |key, oldval, newval| oldval + newval }
  end

  def calculate_key_offset(key)
    index = 0
    @key_offsets.each do |k, v|
      @key_offsets.store(k, key.to_s.slice(index, 2).to_i)
      index += 1
    end

  end

  def calculate_date_offset(date)
    formatted_date = date_to(date)
    squared_date   = square(formatted_date)
    offset         = date_offset(squared_date)
    hash_keys      = @date_offsets.keys

    offset.chars.each_with_index do |value, index|
      @date_offsets.store(hash_keys[index], value.to_i)
    end
  end

  def encryptable_character(char)
    'abcdefghijklmnopqrstuvwxyz0123456789 .,'.include? char
  end
end

