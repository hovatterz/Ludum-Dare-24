module Roguevolution
  class Tile < AStarNode
    TYPES = [:wall, :floor]

    attr_reader :type, :symbol, :passable, :transparent

    def initialize(floor, position, type)
      @floor, @position = floor, position
      @lit = false
      @seen = false
      set_type(type)
    end

    def mutate!(type)
      set_type(type)
    end
    
    def lit?
      @lit == true
    end

    def seen?
      @seen == true
    end

    def light
      @lit = true
      @seen = true
    end

    def unlight
      @lit = false
    end

    def passable?
      passable == true
    end

    def transparent?
      transparent == true
    end

    # AStarNode stuff
    def neighbors
      result = [
        @floor.tile_at(@position + Point.new(0, -1)),
        @floor.tile_at(@position + Point.new(-1,  -1)),
        @floor.tile_at(@position + Point.new(1,  -1)),
        @floor.tile_at(@position + Point.new(0,  1)),
        @floor.tile_at(@position + Point.new(-1,  1)),
        @floor.tile_at(@position + Point.new(1,  1)),
        @floor.tile_at(@position + Point.new(-1, 0)),
        @floor.tile_at(@position + Point.new(1,  0))
      ].delete_if {|node| node.passable == false }
      result
    end

    def guess_distance
      (@position.x - node.position.x).abs + (@position.y - node.position.y).abs
    end

    def movement_cost(neighbor)
      1
    end

    private

    def set_type(type)
      raise ArgumentError, "Invalid type." unless TYPES.include?(type)
      @type = type

      if @type == :wall
        @passable = false
        @transparent = false
      elsif @type == :floor
        @passable = true
        @transparent = true
      end
    end
  end
end
