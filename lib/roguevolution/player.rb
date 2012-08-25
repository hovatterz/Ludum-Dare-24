module Roguevolution
  class Player < Creature
    HIT_DIE = "1d8"
    UNARMED_ATTACK_DIE = "1d4"
    TILE = :player

    attr_accessor :name

    def initialize(dungeon)
      super(dungeon, HIT_DIE, UNARMED_ATTACK_DIE, TILE)
      set_position(dungeon.current_floor.player_start.x,
                   dungeon.current_floor.player_start.y)
      awaken
    end

    def hostile?(creature)
      true
    end
  end
end
