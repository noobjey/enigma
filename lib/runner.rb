#take in input from user
#split it in groups of 4 to be sent to encryptor/decryptor
#get offsets from offset calculator
#send offsets and groups to encrypt || decrypt

#write the encrypted message to encrypt.txt
#write the decrypted message to decrypt.txt

class Runner
attr_reader :message

  def encrypt message
    @message = message
  end
end
