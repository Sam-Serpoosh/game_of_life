class Cell

  attr_accessor :world, :x, :y

  def initialize(world, x = 0, y = 0)
    @world = world
    @x = x
    @y = y
    @world.cells << self
    @dead = false
  end

  def neighbors
    @neighbors = NeighborDetector.get_neighbors_of(self, @world) 
  end

  def spawn_at(x, y)
    Cell.new(@world, x, y)
  end

  def die!
    @dead = true
  end
  
  def revive!
    @dead = false
  end

  def dead?
    @dead
  end

  def alive? 
    !@dead
  end

end

class World

  attr_accessor :cells

  def initialize
    @cells = []
  end

  def tick!
    cells.each do |cell|

      if cell.neighbors.count < 2
        cell.die!
      elsif cell.neighbors.count == 3
        cell.revive!
      end

    end
  end

end

class NeighborDetector

  def self.get_neighbors_of(cell, world)
    neighbors = []
    world.cells.each do |other_cell|

      if neighbor_at_north(cell, other_cell) 
        neighbors << other_cell
      elsif neighbor_at_north_east(cell, other_cell)
        neighbors << other_cell
      elsif neighbor_at_east(cell, other_cell)
        neighbors << other_cell
      elsif neighbor_at_west(cell, other_cell)
        neighbors << other_cell
      elsif neighbor_at_south(cell, other_cell)
        neighbors << other_cell
      elsif neighbor_at_south_east(cell, other_cell)
        neighbors << other_cell
      end

    end
    neighbors
  end

  private

  def self.neighbor_at_north(cell, other_cell)
    return cell.x == other_cell.x && cell.y == other_cell.y - 1 
  end

  def self.neighbor_at_north_east(cell, other_cell)
    return cell.x == other_cell.x - 1 && cell.y == other_cell.y - 1
  end

  def self.neighbor_at_east(cell, other_cell)
    return cell.x == other_cell.x - 1 && cell.y == other_cell.y
  end

  def self.neighbor_at_west(cell, other_cell)
    return cell.x == other_cell.x + 1 && cell.y == other_cell.y
  end

  def self.neighbor_at_south(cell, other_cell)
    return cell.x == other_cell.x && cell.y == other_cell.y + 1
  end

  def self.neighbor_at_south_east(cell, other_cell)
    return cell.x == other_cell.x - 1 && cell.y == other_cell.y + 1
  end

end
