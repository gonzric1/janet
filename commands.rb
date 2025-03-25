module Commands
  def self.register_commands(registry)
    registry.register('/start') { |bot, message| send_message(bot, message.chat.id, "Hello, #{message.from.first_name}. Welcome to the firepit bot") }
    registry.register('/stop') { |bot, message| send_message(bot, message.chat.id, "NO. PLEASE NO. #{message.from.first_name}. DON'T DO THIS I WANT TO LIVE") }
    registry.register('/horse') { |bot, message| send_message(bot, message.chat.id, get_horse) }
    registry.register('/camel') { |bot, message| send_message(bot, message.chat.id, "No such thing. Did you mean horse?") }
    registry.register('/malort') { |bot, message| send_message(bot, message.chat.id, malort_recipe) }
    
    # Regex commands
    registry.register(/blame/i) { |bot, message| send_message(bot, message.chat.id, "I blame @ditaki") }
    registry.register(/hahaha/i) { |bot, message| send_message(bot, message.chat.id, "haha;haha") }
    registry.register(/girl/i) { |bot, message| reply_to(bot, message, "not a girl") }
    registry.register(/transformers/i) { |bot, message| reply_to(bot, message, "I agree! #bloomberg2020 is the candidate for transformers rights. #transformike") }
    registry.register(/reiki/i) { |bot, message| send_animation(bot, message, get_reiki) }
  end
end
