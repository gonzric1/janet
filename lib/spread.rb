class Spread
  attr_reader :name, :slots

  def initialize(name:, slots:)
    @name = name
    @slots = slots
  end

  def self.from_yaml(file_symbol)
    file_path = "lib/data/spreads/#{file_symbol}.yaml"
    data = YAML.load_file(file_path)
    new(name: data['name'], slots: data['slots'].to_a)
  end
end
