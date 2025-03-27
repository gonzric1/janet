
module Commands
class Reiki

end
  REIKI = %w[https://imgur.com/7QVFZxr.gif https://imgur.com/Yo6tY1h.gif https://imgur.com/wDA1Z1b.gif https://imgur.com/8MHPE2H.gif]

  def self.call
    REIKI.sample
  end

end
