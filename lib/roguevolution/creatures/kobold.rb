module Roguevolution
  module Creatures
    class Kobold < Creature
      TILE = :kobold
      HIT_DIE = "1d4"

      def initialize(dungeon)
        super(dungeon, HIT_DIE, TILE)
      end
    end
  end
end
