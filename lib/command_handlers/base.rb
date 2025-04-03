module CommandHandlers
  # Base command handler that registers all command handlers.
  class Base
    # Registers all command handlers with the given registry.
    #
    # @param registry [Object] The registry to register commands with.
    def self.register_all(registry)
      Basic.register(registry)
      Fun.register(registry)
      AI.register(registry)
    end
  end
end
