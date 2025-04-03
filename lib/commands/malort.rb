module Commands
  class GetMalort
    def self.call
      <<~RECIPE
        Malort Cocktail:
        1. Pour 1/2 cup of favorite mixer in a glass with ice. Set aside.
        2. Pour ~1.5floz of malort into a separate container.
        3. Drink Malort.
        This works with any mixer of your choice. Enjoy!
      RECIPE
    end
  end
end