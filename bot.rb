require 'telegram/bot'
require 'dotenv/load'

%w[wotd firepit horse reiki commands ai].each { |file| load "./#{file}.rb" }

TOKEN = ENV['TELEGRAM_TOKEN']
ADMIN_ID = ENV['ADMIN_ID']
ANIMATIONS = {
  wotd: 'https://i.imgur.com/0m8gG1T.gif'
}

class CommandRegistry
  def initialize
    @commands = []
  end

  def register(pattern, &block)
    @commands << [pattern, block]
  end

  def find_handler(text)
    @commands.find { |pattern, _| match?(pattern, text) }&.last
  end

  private

  def match?(pattern, text)
    case pattern
    when String then pattern == text
    when Regexp then pattern.match?(text)
    end
  end
end

class JanetBot
  # Remove extend Commands since we're using class methods directly
  
  def initialize
    @games = {}
    @registry = CommandRegistry.new
    Commands.register_commands(@registry)  # Call class method directly
  end

  def start
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen { |message| handle_message(bot, message) }
    end
  end

  private

  def handle_message(bot, message)
    return unless message.is_a?(Telegram::Bot::Types::Message)
    return unless message.text

    wotd = @games[message.chat.id] ||= WOTD.new(message.chat.id)
    if message.from.id == ADMIN_ID && message.chat.type == 'private'
      if message.text.match?(/^did\b/i)
        rest = message.text.sub(/^did\s+/i, '')
        %x[did -todo #{rest}]
        return
      end
    end

    # Check for word of the day first
    if message.text.match?(/\s#{Regexp.quote(wotd.current_word)}([.,?!\s]|$)/i)
      handle_wotd(bot, message, wotd)
      return
    end

    # Handle other commands
    if (handler = @registry.find_handler(message.text))
      instance_exec(bot, message, &handler)
    end
  end

  def send_message(bot, chat_id, text)
    bot.api.send_message(chat_id: chat_id, text: text)
  end

  def send_silly_message(bot, message, text)
    text_clean = sanitize_message(text)
    response = AI::SillyDefine.new.run(text_clean) || "I'm sorry, I don't know what that means."
    reply_to(bot, message, response)
  end

  def reply_to(bot, message, text)
    bot.api.send_message(
      chat_id: message.chat.id,
      reply_to_message_id: message.message_id,
      text: text
    )
  end

  def send_animation(bot, message, animation)
    bot.api.send_animation(
      chat_id: message.chat.id,
      reply_to_message_id: message.message_id,
      animation: animation
    )
  end

  def handle_wotd(bot, message, wotd)
    reply_to(bot, message, "YOU SAID THE WORD OF THE DAY!!! #{wotd.current_word.upcase}")
    send_animation(bot, message, ANIMATIONS[:wotd])
    wotd.new_word
  end

  def malort_recipe
    <<~RECIPE
      Malort Cocktail:
      1. Pour 1/2 cup of favorite mixer in a glass with ice. Set aside.
      2. Pour ~1.5floz of malort into a separate container.
      3. Drink Malort.
      This works with any mixer of your choice. Enjoy!
    RECIPE
  end

  def sanitize_message(message)
    message.sub('/define ', '')
  end
end

JanetBot.new.start
