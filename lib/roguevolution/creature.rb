module Roguevolution
  class Creature
    attr_reader :health, :max_health, :tile_type, :unarmed_attack_die,
      :traits, :name
    attr_accessor :position

    def initialize(dungeon, name, hit_die, unarmed_attack_die, tile_type)
      @dungeon, @name, @tile_type, @unarmed_attack_die = dungeon, name, tile_type, unarmed_attack_die
      @max_health = RNG.max_roll(hit_die)
      @health = @max_health
      @position = Point.new
      @traits = []
    end

    def armor
      @traits.collect {|trait| trait.defense_modifier }.inject(0, :+)
    end

    def attack(creature)
      damage = roll_damage
      creature.inflict(self, damage)
      if player?
        Announcements.messages << "You hit a #{creature.name} for #{damage} damage."
      else
        Announcements.messages << "A #{name} hits you for #{damage} damage."
      end

      unless creature.alive?
        if player?
          Announcements.messages << "You kill a #{creature.name}."
        else
          Announcements.messages << "A #{name} kills you."
        end
      end
    end

    def alive?
      @health > 0
    end

    def award_trait(creature)
      trait = creature.traits.sample
      unless trait.nil?
        Announcements.messages << trait.message
        @traits << trait
      end
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

    def alerted?
      @alerted == true
    end

    def alert
      @alerted = true
    end

    def player?
      false
    end

    def hostile?(creature)
      creature.player?
    end

    def move(x, y)
      pot_x, pot_y = @position.x + x, @position.y + y
      tile = @dungeon.tile_at(pot_x, pot_y)
      if tile.creature != nil && tile.creature.hostile?(self)
        attack(tile.creature)
        return true
      elsif tile.passable?
        @dungeon.tile_at(@position.x, @position.y).creature = nil
        @position.x = pot_x
        @position.y = pot_y
        tile.creature = self
        return true
      end
      false
    end

    def set_position(x, y)
      @position.set(x, y)
      @dungeon.tile_at(@position.x, @position.y).creature = self
    end

    def take_turn(player)
      ai_wander
      # if alerted?
      #   ai_wander
      # else
      #   ai_chase(player)
      # end
    end

    private

    def ai_wander
      moved = false
      tries = 0
      until moved
        break if tries > 2
        rand_offset = Point.new(Random.rand(-1..1), Random.rand(-1..1))
        moved = true if move(rand_offset.x, rand_offset.y)
        tries += 1
      end
    end

    def ai_chase(creature)
    end

    def roll_damage
      RNG.roll(damage_die) + damage_modifier
    end
  end
end
