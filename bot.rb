require 'telegram/bot'
load './wotd.rb'
load "./firepit.rb"
load "./horse.rb"
load "./reiki.rb"
token = '997881337:AAGouFY6oTXSLEA4lVMdiZ-oESQ0Gxw7KCs'
games = Hash.new

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    wotd = games[message.chat.id] ? games[message.chat.id] : games.store(message.chat.id, WOTD.new(message.chat.id))

    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}. Welcome to the firepit bot")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
   # when '/fire'
   #   puts "Getting Fire info"
   #   response = firepit?
   #   puts "response is: #{response}"
   #   bot.api.send_message(chat_id: message.chat.id, text: "#{response["Friday"]} \n  #{response["Saturday"]}" )
   # when '/weather'
   #   puts "getting current weather"
   #   bot.api.send_message(chat_id: message.chat.id, text: current_weather)
    when '/horse'
      puts "getting horse"
      bot.api.send_message(chat_id: message.chat.id, text: get_horse)
    when /blame/i
      puts "blaming ditaki"
      bot.api.send_message(chat_id: message.chat.id, text: "I blame @ditaki")
    when '/camel'
      puts "wtf is a camel"
      bot.api.send_message(chat_id: message.chat.id, text: "No such thing. Did you mean horse?")
    when '/malort'
      bot.api.send_message(chat_id: message.chat.id, text: "Malort Cocktail: \n 1. Pour 1/2 cup of favorite mixer in a glass with ice. Set aside.\n 2. Pour ~1.5floz of malort into a separate container. \n 3. Drink Malort. \n This works with any mixer of your choice. Enjoy!")
    when /trans/i
      bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: "I agree! #bloomberg2020 is the candidate for trans rights. #transformike")
    when /hahaha/i
      bot.api.send_message(chat_id: message.chat.id, text: "haha;haha")
    when /girl/i
      bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: "not a girl")
    when /reiki/i
      bot.api.send_animation(chat_id: message.chat.id, reply_to_message_id: message.message_id, animation: get_reiki)
    when /\s#{Regexp.quote(wotd.current_word)}([.,?!\s]|$)/i
      puts "wotd"
      bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: "YOU SAID THE WORD OF THE DAY!!! #{wotd.current_word.upcase}")
      bot.api.send_animation(chat_id: message.chat.id, reply_to_message_id: message.message_id, animation: "https://i.imgur.com/0m8gG1T.gif")
      wotd.new_word
    when '/conky'
      puts Regexp.quote(wotd.current_word)
      #bot.api.send_message(chat_id: message.chat.id, reply_to_message_id: message.message_id, text: "#{wotd.current_word}")
    end
  end
end
