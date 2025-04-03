# The BotContext class provides a context for handling bot messages.
# It includes methods for sending messages, replying to messages,
# sending animations, and sending silly messages.
class BotContext
  attr_reader :bot, :message

  # Initializes a new BotContext.
  #
  # @param bot [Telegram::Bot::Client] the bot client
  # @param message [Telegram::Bot::Types::Message] the message object
  def initialize(bot, message)
    @bot = bot
    @message = message
    @logger = Logger.new(STDOUT)
  end

  # Sends a message to the chat.
  #
  # @param text [String] the text to send
  def send_message(text)
    bot.api.send_message(chat_id: message.chat.id, text: text)
  end

  # Replies to a message in the chat.
  #
  # @param text [String] the text to reply with
  def reply_to(text)
    bot.api.send_message(
      chat_id: message.chat.id,
      reply_to_message_id: message.message_id,
      text: text
    )
  end

  # Sends an animation to the chat.
  #
  # @param animation [String] the URL of the animation to send
  def send_animation(animation)
    bot.api.send_animation(
      chat_id: message.chat.id,
      reply_to_message_id: message.message_id,
      animation: animation
    )
  end

  # Sends a photo to the chat.

  # @param photo [String] the URL of the photo to send
  # @param caption [String] the caption for the photo
  def send_photo(photo, caption = nil)
    bot.api.send_photo(
      chat_id: message.chat.id,
      reply_to_message_id: message.message_id,
      photo: photo, 
      caption: caption
    )
  end

  # Sends a silly message based on the provided text.
  #
  # @param text [String] the text to process and send
  def send_silly_message(text)
    text_clean = text.sub('/define ', '')
    return unless text_clean
    response = AI::SillyDefine.new.run(text_clean) || "I'm sorry, I don't know what that means."
    reply_to(response)
  end
end
