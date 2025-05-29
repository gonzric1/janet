require 'yaml'
require 'json'
class Deck
  # initialize the deck with an empty array of cards
  # load ./data/cards.json and create Card objects from the data, add to deck
  # create shuffle method

  attr_accessor :cards
  def initialize
    @cards = []
    load_cards
  end

  def load_cards
    file = File.read('lib/data/cards.json')
    data = JSON.parse(file)
    data['cards'].each do |card_data|
      card = Card.new(
        name: card_data['name'],
        description: card_data['description'],
        meaning_up: card_data['meaning_up'],
        meaning_rev: card_data['meaning_rev'],
        image_path: card_data['image_path'] || 'app/assets/images/cards/placeholder.png'
      )
      @cards << card
    end
  end

  def shuffle
    @cards.each { |card| card.reversed = [ true, false ].sample }
    @cards.shuffle!
  end

  def load_spread(file_path)
    YAML.load_file(file_path)
  end

  def deal_card
    # remove a card from the deck and return it
    return nil if @cards.empty?
    @cards.pop
  end
end
