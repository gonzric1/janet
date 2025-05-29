class Card
  attr_accessor :name, :description, :image_path, :reversed
  attr_reader :meaning_up, :meaning_rev

  def initialize(name:, description:, meaning_up:, meaning_rev:, image_path:)
    @name = name
    @description = description
    @meaning_up = meaning_up
    @meaning_rev = meaning_rev
    @image_path = image_path
    @reversed = [true, false].sample
  end
  # Convert the card to a hash for JSON serialization
  def to_h
    {
      name: @name,
      meaning: meaning,
      reversed: @reversed,
    }
  end

  # Optional: Define a custom to_json method
  def to_json(*_args)
    to_h.to_json
  end

  def meaning
    if @reversed
      "#{@name} (reversed): #{@meaning_rev}"
    else
      "#{@name}: #{@meaning_up}"
    end
  end
end
