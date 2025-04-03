module CommandHandlers
  # Command handler for AI-related commands.
  class AI
    # Registers the AI commands with the given registry.
    #
    # @param registry [Object] The registry to register commands with.
    def self.register(registry)
      registry.register(/^\/define\b/i) do
        send_silly_message(message.text)
      end
      registry.register(/^\/predict\b/i) do
        reader = ::AI::TarotReader.new
        response = reader.run(message.text.sub('/predict ', ''))
        card_image = reader.reading.last_card.image_path
        send_photo(Faraday::UploadIO.new("lib/data/images/#{card_image}", 'image/jpeg'), response)
      end
    end
  end
end