module Roguevolution
  class DungeonFloor
    attr_reader :width, :height, :tiles, :player_start

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
      generator = DungeonGenerator.new(@width, @height)
      generator.generate!
      @tiles = generator.tiles
      @player_start = generator.player_start
    end

    def passable?(x, y)
      @tiles[[x, y]].passable? rescue false
    end
  end
end
