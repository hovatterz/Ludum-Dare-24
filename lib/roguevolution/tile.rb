module Roguevolution
  class Tile
    TYPES = [:wall, :floor]

    attr_reader :type, :symbol, :passable, :transparent

    def initialize(type)
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
