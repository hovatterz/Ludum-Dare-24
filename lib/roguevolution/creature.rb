module Roguevolution
  class Creature
    attr_reader :health, :max_health, :tile_type, :unarmed_attack_die,
      :traits
    attr_accessor :position

    def initialize(dungeon, hit_die, unarmed_attack_die, tile_type)
      @dungeon, @tile_type, @unarmed_attack_die = dungeon, tile_type, unarmed_attack_die
      @awake = false
      @max_health = RNG.max_roll(hit_die)
      @health = @max_health
      @position = Point.new
      @traits = []
    end

    def armor
      @traits.collect {|trait| trait.defense_modifier }.inject(0, :+)
    end

    def attack(creature)
      creature.inflict(self, roll_damage)
    end

    def alive?
      @health > 0
    end

    def award_trait(creature)
      trait = creature.traits.sample
      @traits << trait unless trait.nil?
    end

    def damage_die
      @unarmed_attack_die
    end

    def damage_modifier
      @traits.collect {|trait| trait.unarmed_modifier }.inject(0, :+)
    end

    def inflict(inflictor, damage)
      num_acid = @traits.select {|trait|
        trait.class == Trait::AcidicBlood
      }.length

      if inflictor && num_acid > 0
        num_acid.times do
          if Trait::AcidicBlood.roll_chance
            inflictor.inflict(nil, Trait::AcidicBlood.roll_damage)
          end
        end
      end

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
      RNG.roll(damage_die) + damage_modifier
    end
  end
end
