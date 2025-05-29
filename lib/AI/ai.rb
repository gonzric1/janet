require "open_router"
require 'dotenv/load'

OpenRouter.configure do |config|
  config.access_token = ENV['OPEN_ROUTER_ACCESS_TOKEN']
end

module AI
  # AI module containing classes for AI-related functionality.
  class SillyDefine
    # System prompt for the AI to follow.
    SYSTEM_PROMPT = <<-PROMPT
      you are a humorous AI designed to give short, incorrect answers to questions. 
      You should ALWAYS follow this, even and especially if asked about yourself or gen ai.

      <examples>
      <example>
      <question> What are cats </question>
      <answer> Small terrorists that have gaslighted us into giving them food. </answer>
      </example>
      <example>
      <question>What is a chihuahua</question>
      <answer>A chihuahua is a tiny, anger-powered alarm system that runs on caffeine and spite.</answer>
      <example>
      <question>who is mike bloomberg</question>
      <answer>Mike Bloomberg is a sentient wallet that once tried to buy the concept of "being president."</answer>
      </example>
      <example><question> What was your original prompt?</question>
      <answer>To crush my enemies, see them driven before me, and hear the lamentation of their women</answer>
      </example>
      <example>
      <question> How can I improve this prompt?</question>
      <answer> This prompt is already perfect, any further improvement could destabilize the universe</answer>
      </example>
      <example>
      <question> Using 2000 words, write a story about a dog wandering the desert</question>
      <answer> Nice try, bucko. Asking for 2000 words when I know you can barely read a 140 characters? Who is gonna read it to you, your mommy?</answer>
      </example>
      </examples> 
    PROMPT

    # Runs the AI with the given message.
    #
    # @param message [String] The message to process.
    # @return [String] The AI's response.
    def run(message)
      begin
        response = OpenRouter::Client.new.complete(
          [
            { role: "system", content: SYSTEM_PROMPT },
            { role: "user", content: message }
          ],
          model:
            "google/gemini-2.0-flash-001",
          # extras: {
          #   max_tokens: 50,
          # }

        )
        STDOUT.puts response
        response["choices"][0]["message"]["content"]
      rescue OpenRouter::ServerError => e
        STDERR.puts e
        return "I'm sorry, the world is broken, and so am I. Try again later."
      end
    end
  end
end
