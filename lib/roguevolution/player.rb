module Roguevolution
  class Player
    attr_reader :x, :y
    
    def initialize
      @x = 0
      @y = 0
    end

    def move(dungeon, x, y)
      pot_x = @x + x
      pot_y = @y + y
      if dungeon.tile_at(pot_x, pot_y).passable?
        @x = pot_x
        @y = pot_y
      end
    end

    def set_position(x, y)
      @x, @y = x, y
    end
  end
end
