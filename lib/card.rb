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

  def meaning
    if @reversed
      "#{@name} (reversed): #{@meaning_rev}"
    else
      "#{@name}: #{@meaning_up}"
    end
  end
end
