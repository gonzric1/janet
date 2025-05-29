require_relative 'lib/reading'
require_relative 'lib/deck'
require_relative 'lib/spread'
require_relative 'lib/card'

# Initialize the Reading class
reading = Reading.new

# Perform the reading
reading.perform_reading

# Output the selected cards
puts reading.formatted_json

# puts "Selected Cards:"
# reading.selected_cards.each_with_index do |card, index|
#   puts "Slot #{index + 1}:"
#   puts "  slot: #{card[:meaning]}"
#   puts "  Card: #{card[:card]}" # Assuming `card` has a `meaning` method
# end

# # Output the selected cards as JSON
# puts "\nSelected Cards (JSON):"
# puts reading.to_json