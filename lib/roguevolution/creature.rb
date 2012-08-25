module Roguevolution
  class Creature
    attr_reader :health, :tile_type, :position, :unarmed_attack_die

    def initialize(dungeon, hit_die, unarmed_attack_die, tile_type)
      @dungeon, @tile_type, @unarmed_attack_die = dungeon, tile_type, unarmed_attack_die
      @awake = false
      @health = RNG.roll(hit_die)
      @position = Point.new
    end

    def attack(creature)
      creature.inflict(roll_damage)
    end

    def alive?
      @health > 0
    end

    def inflict(damage)
      puts "New Health: #{@health - damage}"
      @health -= damage
    end

    def awake?
      @awake == true
    end

    def awaken
      @awake = true
    end

    def sleep
      @awake = false
    end

    def hostile?(creature)
      creature.tile_type == :player
    end

    def move(x, y)
      pot_x, pot_y = @position.x + x, @position.y + y
      tile = @dungeon.tile_at(pot_x, pot_y)
      if tile.creature != nil && tile.creature.hostile?(self)
        attack(tile.creature)
      elsif tile.passable?
        @dungeon.tile_at(@position.x, @position.y).creature = nil
        @position.x = pot_x
        @position.y = pot_y
        tile.creature = self
      end
    end

    def set_position(x, y)
      @position.set(x, y)
      @dungeon.tile_at(@position.x, @position.y).creature = self
    end

    private

    def roll_damage
      RNG.roll(@unarmed_attack_die)
    end
  end
end
