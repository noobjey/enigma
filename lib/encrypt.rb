class Encrypt

#get offsets [6, 8, 10, 12] and message [[t, u, r, i], [n, g]]
#add the offsets to the index value of each message component
#character map: 39 values, indexed 0-39
#loop through to add offsest

#perhaps join values to string here?
#perhaps write to file here?
  attr_reader :date_offsets, :key_offsets, :total_offsets

  def initialize
    @date_offsets  = { a: 0, b: 0, c: 0, d: 0 }
    @key_offsets   = { a: 0, b: 0, c: 0, d: 0 }
    @total_offsets = { a: 0, b: 0, c: 0, d: 0 }
  end

  def date_to date
    date.strftime("%d%m%y")
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

  def encrypt(date = Date.new(2001, 1, 1), key = 41521, message = '')

    # probably a terrible person for code below
    offset    = date_offset(square(date_to(date)))
    hash_keys = @date_offsets.keys

    offset.chars.each_with_index do |value, index|
      @date_offsets.store(hash_keys[index], value.to_i)
    end

    index = 0
    @key_offsets.each do |k, v|
      @key_offsets.store(k, key.to_s.slice(index, 2).to_i)
      index += 1
    end

    @total_offsets.merge!(@date_offsets) { |key, oldval, newval| oldval + newval }
    @total_offsets.merge!(@key_offsets) { |key, oldval, newval| oldval + newval }

    encrypted_message = ''
    message.chars.each_with_index do |character, index|
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

      offset = @total_offsets[key].to_i
      encrypted_character = rotate character, offset
      encrypted_message << encrypted_character
    end
    encrypted_message
  end

end

