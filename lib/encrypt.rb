class Encrypt

#get offsets [6, 8, 10, 12] and message [[t, u, r, i], [n, g]]
#add the offsets to the index value of each message component
#character map: 39 values, indexed 0-39
#loop through to add offsest

#perhaps join values to string here?
#perhaps write to file here?
  attr_reader :date_offsets, :key_offsets

  def initialize
    @date_offsets = { a: 0, b: 0, c: 0, d: 0 }
    @key_offsets = { a: 0, b: 0, c: 0, d: 0 }
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

  def encrypt(date = Date.new(2001,1,1), key = 41521)

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

  end

end

