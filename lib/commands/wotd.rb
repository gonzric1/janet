require 'securerandom'

module Commands
  class GetWOTD
    def self.call
      @words = File.readlines("words.txt", chomp: true)
      @words.sample(random: SecureRandom)
    end
  end
end
