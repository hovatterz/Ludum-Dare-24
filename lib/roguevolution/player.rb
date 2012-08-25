module Roguevolution
  class Player
    attr_reader :current_floor, :x, :y
    
    def initialize
      @x = 0
      @y = 0
      @current_floor = 0
    end

    def move(dungeon, x, y)
      pot_x = @x + x
      pot_y = @y + y
      if dungeon.floors[@current_floor].passable?(pot_x, pot_y)
        @x = pot_x
        @y = pot_y
      end
    end

    def set_position(x, y)
      @x, @y = x, y
    end
  end
end
