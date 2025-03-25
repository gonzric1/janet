require 'securerandom'

class WOTD
  attr_reader :current_word, :chat_id
  def initialize(chat_id)
    @chat_id = chat_id
    @words = File.readlines("words.txt", chomp: true)
    @current_word = @words.sample(random: SecureRandom)
  end
  
  def print_test
    puts "Chat ID:  #{@chat_id} Current Word: #{word_random}"
    pp @words
  end
  
  def new_word
    @current_word = @words.sample(random: SecureRandom)
  end
end
