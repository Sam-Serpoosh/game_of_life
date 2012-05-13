

describe "game of life" do

  let(:world) { World.new } 

  context "utility methods" do

    subject { Cell.new(world) }

    it "spawn relative to" do
      cell = subject.spawn_at(3, 5)
      cell.is_a?(Cell).should be_true
      cell.x.should == 3
      cell.y.should == 5
      cell.world.should == subject.world
    end

    it "detects a neighbor to the north" do
      cell = subject.spawn_at(0, 1)
      subject.neighbors.count.should == 1
    end

    it "detects a neighbor to the north east" do
      cell = subject.spawn_at(1, 1)
      subject.neighbors.count.should == 1
    end

    it "should be dead in next generation in under-population" do
      subject.next_generation
      subject.should be_dead
    end

  end

  it "any live cell with fewer than two live neighbors die" do
    cell = Cell.new(world)
    new_cell = cell.spawn_at(2, 0)
    world.tick!
    cell.should be_dead
  end

end


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
    @neighbors = []
    @world.cells.each do |cell|
      #Has a cell to the north
      if self.x == cell.x && self.y == cell.y - 1
        @neighbors << cell
      end 

      #Has a cell to the north east
      if self.x == cell.x - 1 && self.y == cell.y - 1
        @neighbors << cell
      end
    end

    @neighbors
  end

  def spawn_at(x, y)
    Cell.new(@world, x, y)
  end

  def next_generation
    if neighbors.count < 2
      @dead = true
    end
  end

  def dead?
    @dead
  end

end

class World

  attr_accessor :cells

  def initialize
    @cells = []
  end

  def tick!
    cells.each do |cell|
      cell.next_generation
    end
  end

end
