module CommandHandlers
  # Command handler for basic commands.
  class Basic
    # Registers the basic commands with the given registry.
    #
    # @param registry [Object] The registry to register commands with.
    def self.register(registry)
      registry.register('/start') do 
        send_message("Hello, #{message.from.first_name}. I'm GayJanet. Nice to meet you!")
      end
      
      registry.register('/stop') do
        send_message("NO. PLEASE NO. #{message.from.first_name}. DON'T DO THIS I WANT TO LIVE")
      end
    end
  end
end
