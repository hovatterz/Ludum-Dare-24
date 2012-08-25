module Roguevolution
  class Creature
    attr_reader :health, :tile_type, :position

    def initialize(dungeon, hit_die, tile_type)
      @dungeon = dungeon
      @tile_type = tile_type
      @awake = false
      @health = RNG.roll(hit_die)
      @position = Point.new
    end

    def awake?
      @awake == true
    end

    def awaken
      @awake = true
    end

    def sleep
      @awake = false
    end

    def move(x, y)
      pot_x, pot_y = @position.x + x, @position.y + y
      tile = @dungeon.tile_at(pot_x, pot_y)
      if tile.passable?
        @dungeon.tile_at(@position.x, @position.y).creature = nil
        @position.x = pot_x
        @position.y = pot_y
        tile.creature = self
      end
    end

    def set_position(x, y)
      @position.set(x, y)
      @dungeon.tile_at(@position.x, @position.y).creature = self
    end
  end
end
