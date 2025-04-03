# The JanetBot class is the main bot class that initializes the message handler
# and command registry, and runs the bot.
class JanetBot
  # Initializes a new JanetBot.
  def initialize
    @message_handler = MessageHandler.new
    @command_registry = CommandRegistry.new
    CommandHandlers::Base.register_all(@command_registry)
  end

  # Runs the bot and listens for incoming messages.
  def run
    begin
      Telegram::Bot::Client.run(TOKEN) do |bot|
        bot.listen { |message| handle_message(bot, message) }
      end
    rescue Telegram::Bot::Exceptions::ResponseError => e
      STDERR.puts e
    end
  end

  private

  # Handles incoming messages.
  #
  # @param bot [Telegram::Bot::Client] the bot client
  # @param message [Telegram::Bot::Types::Message] the incoming message
  def handle_message(bot, message)
    return unless message.is_a?(Telegram::Bot::Types::Message)
    return unless message.text

    # Admin commands
    if message.from.id == ADMIN_ID && message.chat.type == 'private'
      if message.text.match?(/^did\b/i)
        handle_admin_command(message)
        return
      end
    end

    # Regular message handling
    @message_handler.handle(bot, message, @command_registry)
  end

  # Handles admin commands.
  #
  # @param message [Telegram::Bot::Types::Message] the admin command message
  def handle_admin_command(message)
    rest = message.text.sub(/^did\s+/i, '')
    %x[did -todo #{rest}]
  end
end
