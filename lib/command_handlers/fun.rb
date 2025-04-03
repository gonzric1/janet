module CommandHandlers
  # Command handler for fun commands.
  class Fun
    # Registers the fun commands with the given registry.
    #
    # @param registry [Object] The registry to register commands with.
    def self.register(registry)
      registry.register('/horse') { send_message(Commands::GetHorse.call) }
      registry.register('/camel') { send_message("No such thing. Did you mean horse?") }
      registry.register('/malort') { send_message(Commands::GetMalort.call) }
      
      # Regex commands
      registry.register(/blame/i) { send_message("I blame @ditaki") }
      registry.register(/hahaha/i) { send_message("haha;haha") }
      registry.register(/girl/i) { reply_to("not a girl") }
      registry.register(/transformers/i) { reply_to("I agree! #bloomberg2020 is the candidate for transformers rights. #transformike") }
      registry.register(/reiki/i) { send_animation(Commands::GetReiki.call) }
    end
  end
end
