class Reading
  attr_accessor :spread, :deck, :selected_cards

  def initialize(spread: Spread.from_yaml(:three_card), deck: Deck.new)
    @spread = spread
    @deck = deck
    @selected_cards = []
    @deck.shuffle
  end

  def perform_reading
    return @selected_cards unless @selected_cards.empty?
  
    @spread.slots.each do |slot|
      card = @deck.deal_card
      @selected_cards << {
        meaning: slot['meaning'],
        card: card.to_h # Convert the card to a hash
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

  def to_json
    @json||= perform_reading.to_json
  end 

    # ...existing code...
  
    def formatted_json
      cards = @selected_cards.map.with_index do |selected_card, index|
        {
          slot: @spread.slots[index]['position'],
          slot_description: @spread.slots[index]['position'],
          card_name: selected_card[:card][:name],
          reversed: selected_card[:card][:reversed],
          card_description: selected_card[:card][:meaning]
        }
      end
  
      { cards: cards }.to_json
    end
  
  # ...existing code...
end
