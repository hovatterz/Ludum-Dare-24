module Roguevolution
  class DungeonFloor
    attr_reader :width, :height, :tiles

    def initialize(width, height)
      @width = width
      @height = height
      @tiles = {}
    end

    def each_tile
      @width.times do |x|
        @height.times do |y|
          yield(x, y)
        end
      end
    end

    def generate!
      @width.times do |x|
        @height.times do |y|
          tile_type = Tile::TYPES[Random.rand(0...Tile::TYPES.length)]
          @tiles[[x, y]] = Tile.new(tile_type)
        end
      end
    end

    def passable?(x, y)
      @tiles[[x, y]].passable? rescue false
    end
  end
end
