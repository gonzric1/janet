require "open_router"
require 'dotenv/load'

OpenRouter.configure do |config|
  config.access_token = ENV['OPEN_ROUTER_ACCESS_TOKEN']
end

module AI
  class SillyDefine
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
      </examples> 
    PROMPT
    def run(message)
      response = OpenRouter::Client.new.complete(
        [
          { role: "system", content: SYSTEM_PROMPT },
          { role: "user", content: sanitize_message(message) }
        ],
        model:
          "google/gemini-2.5-pro-exp-03-25:free"
      )
      response["choices"][0]["message"]["content"]
    end

    private

    def sanitize_message(message)
      message.text.sub('/define ', '')
    end
  end
end
