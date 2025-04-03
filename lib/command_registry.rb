# The CommandRegistry class manages the registration and lookup of command handlers.
class CommandRegistry
  # Initializes a new CommandRegistry.
  def initialize
    @commands = []
  end

  # Registers a command pattern with a handler block.
  #
  # @param pattern [String, Regexp] the pattern to match commands
  # @yield the block to execute when the pattern matches
  def register(pattern, &block)
    @commands << [pattern, block]
  end

  # Finds a handler for the given text.
  #
  # @param text [String] the text to match against registered patterns
  # @return [Proc, nil] the handler block if a match is found, otherwise nil
  def find_handler(text)
    @commands.find { |pattern, _| match?(pattern, text) }&.last
  end

  private

  # Checks if the text matches the pattern.
  #
  # @param pattern [String, Regexp] the pattern to match
  # @param text [String] the text to check
  # @return [Boolean] true if the pattern matches the text, otherwise false
  def match?(pattern, text)
    case pattern
    when String then pattern == text
    when Regexp then pattern.match?(text)
    end
  end
end
