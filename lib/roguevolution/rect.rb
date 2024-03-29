module Roguevolution
  class Rect
    attr_accessor :x, :y, :x2, :y2

    def initialize(x, y, width, height)
      @x = x
      @y = y
      @x2 = x + width
      @y2 = y + height
    end

    def center
      Point.new((@x + @x2) / 2, (@y + @y2) / 2)
    end

    def contains?(point)
      point.x <= @x2 and point.x >= @x and
      point.y <= @y2 and point.y >= @y
    end

    def intersects?(other)
      @x <= other.x + other.x2 and @x2 >= other.x and
      @y <= other.y + other.y2 and @y2 >= other.y
    end

    def random_point
      Point.new(Random.rand((@x + 1)..@x2), Random.rand((@y + 1)..@y2))
    end
  end
end
