module Roguevolution
  class Tilebank
    TILES = [:player, :wall, :floor, :blood, :kobold, :ooze]

    def self.[](type)
      TILES.find_index(type)
    end

    def self.include?(type)
      TILES.include?(type)
    end
  end
end
