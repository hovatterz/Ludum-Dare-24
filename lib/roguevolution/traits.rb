module Roguevolution
  class Trait
    attr_reader :name, :defense_modifier, :unarmed_modifier

    def initialize(name)
      @defense_modifier = 0
      @unarmed_modifier = 0
      @name = name
    end

    class LeatherSkin < Trait
      def initialize
        super("Leathery Skin")
        @defense_modifier = 1
      end
    end

    class Claws < Trait
      def initialize
        super("Claw-like Hands")
        @unarmed_modifier = 1
      end
    end
  end
end
