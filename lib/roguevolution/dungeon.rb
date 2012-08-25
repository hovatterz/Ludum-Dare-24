module Roguevolution
  class Dungeon
    attr_reader :floors, :width, :height

    def initialize(num_floors, width, height)
      @width = width
      @height = height
      @current_floor = 0
      @floors = [].fill(DungeonFloor.new(@width, @height), 0, num_floors)
    end

    def generate!
      @floors.each do |floor|
        floor.generate!
      end
    end

    def current_floor
      @floors[@current_floor]
    end

    def darken
      current_floor.each_tile do |x, y|
        tile_at(x, y).unlight
      end
    end

    def tile_at(x, y)
      @floors[@current_floor].tiles[[x, y]]
    end
  end
end
