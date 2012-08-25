module Roguevolution
  module Creatures
    class Ooze < Creature
      HIT_DIE = "1d8"
      UNARMED_ATTACK_DIE = "1d4"
      TILE = :ooze

      def initialize(dungeon)
        super(dungeon, "Ooze", HIT_DIE, UNARMED_ATTACK_DIE, TILE)
        @traits << Trait::AcidicBlood.new
      end
    end
  end
end

