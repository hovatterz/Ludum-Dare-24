module Roguevolution
  module Creatures
    class Kobold < Creature
      HIT_DIE = "1d4"
      UNARMED_ATTACK_DIE = "1d2"
      TILE = :kobold

      def initialize(dungeon)
        super(dungeon, HIT_DIE, UNARMED_ATTACK_DIE, TILE)
      end
    end
  end
end
