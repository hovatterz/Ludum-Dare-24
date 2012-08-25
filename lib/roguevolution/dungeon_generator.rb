module Roguevolution
  class DungeonGenerator
    attr_reader :tiles, :player_start, :creatures

    MIN_ROOM_SIZE = 3
    MAX_ROOM_SIZE = 12
    MAX_NUM_ROOMS = 100
    MIN_CREATURE_SPAWNS = 1
    MAX_CREATURE_SPAWNS = 4

    def initialize(dungeon, width, height)
      @dungeon, @width, @height = dungeon, width, height
      @tiles = {}
      @rooms = {}
      @creatures = []
    end

    def generate!
      # Fill with walls
      @width.times do |x|
        @height.times do |y|
          @tiles[[x, y]] = Tile.new(@dungeon.current_floor, Point.new(x, y), :wall)
        end
      end

      last_rect = nil
      MAX_NUM_ROOMS.times do |r|
        w = Random.rand(MIN_ROOM_SIZE..MAX_ROOM_SIZE)
        h = Random.rand(MIN_ROOM_SIZE..MAX_ROOM_SIZE)
        x = Random.rand(1..(@width - w - 2))
        y = Random.rand(1..(@height - h - 2))
        new_room = {}
        new_room[:rect] = Rect.new(x, y, w, h)

        failed = false
        @rooms.each do |other_rect, other_room|
          if new_room[:rect].intersects?(other_rect)
            failed = true
            break
          end
        end

        unless failed
          create_room(new_room[:rect])
          new_center = new_room[:rect].center

          if @rooms.empty?
            @player_start = new_center
          else
            old_center = last_rect.center
            if Random.rand(0..1) == 1
              # first move horizontally, then vertically
              create_h_tunnel(old_center.x, new_center.x, old_center.y)
              create_v_tunnel(old_center.y, new_center.y, new_center.x)
            else
              # first move vertically, then horizontally
              create_v_tunnel(old_center.y, new_center.y, old_center.x)
              create_h_tunnel(old_center.x, new_center.x, new_center.y)
            end
          end

          num_creatures = Random.rand(MIN_CREATURE_SPAWNS..MAX_CREATURE_SPAWNS)
          num_creatures.times do
            position = nil
            until position
              random_position = new_room[:rect].random_point
              position = random_position unless @tiles[[random_position.x, random_position.y]].creature
            end

            creature = Creatures::Kobold.new(@dungeon)
            creature.position = position
            @tiles[[position.x, position.y]].creature = creature
            @creatures << creature
          end

          @rooms[new_room[:rect]] = new_room
          last_rect = new_room[:rect]
        end
      end
    end

    private


    # Carves out a room
    def create_room(rect)
      x_min = rect.x + 1
      x_max = rect.x2
      y_min = rect.y + 1
      y_max = rect.y2

      (x_min..x_max).each do |x|
        (y_min..y_max).each do |y|
          @tiles[[x, y]].mutate!(:floor)
        end
      end
    end

    # Creates a horizontal tunnel
    def create_h_tunnel(x, x2, y)
      min = [x, x2].min
      max = [x, x2].max

      (min..max).each do |x|
        @tiles[[x, y]].mutate!(:floor)
      end
    end

    # Creates a vertical tunnel
    def create_v_tunnel(y, y2, x)
      min = [y, y2].min
      max = [y, y2].max

      (min..max).each do |y|
        @tiles[[x, y]].mutate!(:floor)
      end
    end
  end
end
