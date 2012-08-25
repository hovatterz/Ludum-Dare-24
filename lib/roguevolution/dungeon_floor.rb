module Roguevolution
  class DungeonFloor
    attr_reader :dungeon, :width, :height, :tiles, :player_start,
      :creatures

    def initialize(dungeon, width, height)
      @dungeon, @width, @height = dungeon, width, height
      @tiles = {}
      @creatures = []
    end

    def each_tile
      @width.times do |x|
        @height.times do |y|
          yield(x, y)
        end
      end
    end

    def generate!
      generator = DungeonGenerator.new(@dungeon, @width, @height)
      generator.generate!
      @tiles = generator.tiles
      @player_start = generator.player_start
      @creatures = generator.creatures
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
