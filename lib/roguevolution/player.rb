module Roguevolution
  class Player < Creature
    HIT_DIE = "1d8"
    TILE = :player

    attr_accessor :name

    def initialize(dungeon)
      super(dungeon, HIT_DIE, TILE)
      set_position(dungeon.current_floor.player_start.x,
                   dungeon.current_floor.player_start.y)
      awaken
    end
  end
end
