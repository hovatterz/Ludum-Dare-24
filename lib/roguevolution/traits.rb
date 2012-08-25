module Roguevolution
  class Trait
    attr_reader :name, :message, :defense_modifier, :unarmed_modifier

    def initialize(name, message)
      @defense_modifier = 0
      @unarmed_modifier = 0
      @name, @message = name, message
    end

    class LeatherSkin < Trait
      def initialize
        super("Leathery Skin", "Your skin grows more leathery.")
        @defense_modifier = 1
      end
    end

    class Claws < Trait
      def initialize
        super("Claw-like Hands", "Your hands grow more claw-like.")
        @unarmed_modifier = 1
      end
    end

    class AcidicBlood < Trait
      DAMAGE_DIE = "1d2"

      def self.roll_chance
        Random.rand(0..2) == 0
      end

      def self.roll_damage
        RNG.roll(DAMAGE_DIE)
      end

      def initialize
        super("Acidic Blood", "Your blood grows more acidic.")
      end
    end
  end
end
