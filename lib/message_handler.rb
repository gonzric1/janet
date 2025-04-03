# The MessageHandler class handles incoming messages and commands.
class MessageHandler
  ANIMATIONS = {
    wotd: 'https://i.imgur.com/0m8gG1T.gif'
  }

  # Initializes a new MessageHandler.
  def initialize
    @games = {}
  end

  # Handles an incoming message.
  #
  # @param bot [Telegram::Bot::Client] the bot client
  # @param message [Telegram::Bot::Types::Message] the incoming message
  # @param command_registry [CommandRegistry] the command registry
  def handle(bot, message, command_registry)
    # Check for word of the day first
    @games[message.chat.id] ||= Commands::GetWOTD.call
    
    if message.text.match?(/\s#{Regexp.quote(@games[message.chat.id] )}([.,?!\s]|$)/i)
      handle_wotd(bot, message, wotd)
      return
    end

    # Handle commands
    if (handler = command_registry.find_handler(message.text))
      STDOUT.puts "Handling command: #{message.text}"
      bot_context = BotContext.new(bot, message)
      bot_context.instance_exec(&handler)
    end
  end

  # Handles the word of the day message.
  #
  # @param bot [Telegram::Bot::Client] the bot client
  # @param message [Telegram::Bot::Types::Message] the incoming message
  # @param wotd [String] the word of the day
  def handle_wotd(bot, message, wotd)
    send_reply(bot, message, "YOU SAID THE WORD OF THE DAY!!! #{wotd.current_word.upcase}")
    send_animation(bot, message, ANIMATIONS[:wotd])
    @games[message.chat.id] = Commands::GetWOTD.call
  end

  # Sends a reply to a message.
  #
  # @param bot [Telegram::Bot::Client] the bot client
  # @param message [Telegram::Bot::Types::Message] the incoming message
  # @param text [String] the text to reply with
  def send_reply(bot, message, text)
    bot.api.send_message(
      chat_id: message.chat.id,
      reply_to_message_id: message.message_id,
      text: text
    )
  end

  # Sends an animation to the chat.
  #
  # @param bot [Telegram::Bot::Client] the bot client
  # @param message [Telegram::Bot::Types::Message] the incoming message
  # @param animation [String] the URL of the animation to send
  def send_animation(bot, message, animation)
    bot.api.send_animation(
      chat_id: message.chat.id,
      reply_to_message_id: message.message_id,
      animation: animation
    )
  end
end
