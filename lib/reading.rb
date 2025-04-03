class Reading
  attr_accessor :spread, :deck, :selected_cards

  def initialize(spread: Spread.from_yaml(:three_card), deck: Deck.new)
    @spread = spread
    @deck = deck
    @selected_cards = []
    @current_slot_index = 0
    @deck.shuffle
  end

  def perform_reading
    @spread.slots.each do |slot|
      card = @deck.deal_card
      @selected_cards << {
        meaning: slot['meaning'],
        card: card
      }
    end
    @selected_cards
  end

  def deal_one_slot
    return "summarize the entire reading" if @selected_cards.length >= @spread.slots.size
    slot = @spread.slots[@selected_cards.length]
    puts slot
    card = @deck.deal_card
    @selected_cards << {
      meaning: slot["meaning"],
      card: card
    }

    "#{slot['meaning']} + #{card.meaning}"
  end

  def last_card
    return nil if @selected_cards.empty?
    @selected_cards.last[:card]
  end
end
