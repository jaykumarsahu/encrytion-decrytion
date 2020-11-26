require 'pry'
require 'openssl'
require 'base64'
require 'json'

# https://gist.github.com/GuyPaddock/346b8a7f945a535bc1ba77166ed27b0a

def encrypt(decrypted_text)
  cert = OpenSSL::X509::Certificate.new(File.read('certificate.crt'))
  asymmetric_cipher = cert.public_key
  asymmetric_cipher.public_encrypt(decrypted_text, OpenSSL::PKey::RSA::PKCS1_OAEP_PADDING)
end

def decrypt(encrypted_text, password)
  pkcs = OpenSSL::PKCS12.new(File.read('certificate.pfx'), password)
  pkcs.key.private_decrypt(encrypted_text, OpenSSL::PKey::RSA::PKCS1_OAEP_PADDING)
end



password = "password"

text = "Hello world"

puts '==============string before encryption================='
puts text
puts '==============string after encryption================='
encrypted_text = encrypt(text)
puts encrypted_text
puts '==============string after decryption================='
puts decrypt(encrypted_text, password)