# frozen_string_literal: true

module AI

  class TarotReader
    attr_reader :reading
          SYSTEM_PROMPT = <<~PROMPT
      You are a tarot reader. You will be given a tarot card inside <card_drawn> tag  with it's name and meaning, 
      and a question inside <question> tag,
      Provide a meaningful interpretation of the card based on the question. Be sure to include the card name and
      slot purpose. 

      Keep your response short and concise, this is only one card out of many. 

      <example>
      <question> will the server run? </question>
      <card_drawn>Card pulled Represents past events that influence the present. + Wheel Of Fortune (reversed): Increase, abundance, superfluity.</card_drawn>
      <response>
      The reversed Wheel of Fortune indicates previously favorable circumstances have become disrupted, causing missed opportunities and stagnation.
      This past disruption affects your present situation, creating uncertainty in progress.

      Consider if you're resisting necessary change or using outdated approaches.
      Re-evaluate your strategies, adapt to current circumstances, and release excessive control.
      By aligning with the natural flow of events, you can reconnect with the Wheel's positive aspects and overcome these constraints.
      </response>
      </example>
    PROMPT

    def initialize(reading: Reading.new)
      @reading = reading
    end
    def run(question)
      begin
        response = OpenRouter::Client.new.complete(
          [
            { role: "system", content: SYSTEM_PROMPT },
            { role: "user", content: generate_content(question) }
          ],
          model:
            "google/gemini-2.0-flash-001"
        )
        answer = response["choices"][0]["message"]["content"]
        puts answer
        answer
      rescue OpenRouter::ServerError => e
        STDERR.puts e
        return "I'm sorry, the world is broken, and so am I. Try again later."
      end
    end

    private

    def generate_content(question)
      prompt = <<~PROMPT
        `"<question> #{question}.</question>
          <card_drawn>#{@reading.deal_one_slot}"</card_drawn>
      PROMPT
      puts prompt
      prompt
    end
  end
end
