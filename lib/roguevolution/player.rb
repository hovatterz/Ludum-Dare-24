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
      reset_turn

      @name = "Player"
    end

    def hostile?(creature)
      true
    end

    def player?
      true
    end

    def move(x, y)
      @turn_taken = super(x, y)
    end

    def reset_turn
      @turn_taken = false
    end

    def turn_taken?
      @turn_taken == true
    end
  end
end
