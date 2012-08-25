module Roguevolution
  class DungeonRoom
    MIN_CREATURE_SPAWNS = 1
    MAX_CREATURE_SPAWNS = 4

    attr_reader :rect, :creature_spawns

    def initialize(rect)
      @rect = rect
      generate_creature_spawns
    end

    private

    def generate_creature_spawns
      @creature_spawns = []
    end
  end
end
