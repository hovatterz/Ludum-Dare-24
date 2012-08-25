module Roguevolution
  class Dungeon
    attr_reader :floors, :width, :height

    def initialize(num_floors, width, height)
      @width = width
      @height = height
      @floors = [].fill(DungeonFloor.new(@width, @height), 0, num_floors)
    end

    def generate!
      @floors.each do |floor|
        floor.generate!
      end
    end
  end
end
