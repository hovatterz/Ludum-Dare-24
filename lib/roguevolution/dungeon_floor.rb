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

    def save(file_name)
      File.open(file_name, "w") do |file|
        @height.times do |y|
          @width.times do |x|
            file << "\n" if x == 0
            file << "#" if @tiles[[x, y]].type == :wall
            file << "." if @tiles[[x, y]].type == :floor
          end
        end
      end
    end

    def passable?(x, y)
      @tiles[[x, y]].passable? rescue false
    end
  end
end
