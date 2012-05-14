require './gol'

describe "game of life" do

  let(:world) { World.new } 

  context "utility methods" do

    subject { Cell.new(world) }

    it "spawns relative to" do
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

    it "detects a neighbor to the west" do
      cell = subject.spawn_at(-1, 0)
      subject.neighbors.count.should == 1
    end

    it "detects a neighbor to the east" do
      cell = subject.spawn_at(1, 0)
      subject.neighbors.count.should == 1
    end

    it "dies and will" do
      subject.die!
      subject.should be_dead
    end

  end

  it "any live cell with fewer than two live neighbors die" do
    cell = Cell.new(world)
    new_cell = cell.spawn_at(2, 0)
    world.tick!
    cell.should be_dead
  end

  it "any live cell with 2 or 3 live neighbor survive to the next generation" do
    cell = Cell.new(world)
    new_cell = cell.spawn_at(1, 0)
    other_new_cell = cell.spawn_at(-1, 0)
    world.tick!
    cell.should be_alive
  end

  it "any dead cell with exactly 3 neighbors will be back to life" do
    cell = Cell.new(world)
    cell.die!
    cell.should be_dead

    neighbor1 = cell.spawn_at(1, 0)
    neighbor2 = cell.spawn_at(-1, 0)
    neighbor3 = cell.spawn_at(1, 1)
    world.tick!
    cell.should be_alive
  end

end

describe "neighbor detector" do

  let(:world) { World.new }

  before do
    @subject = Cell.new(world)
  end

  it "detects north neighbor of a cell" do
    detect_neighbor(0, 1, 1)
  end

  it "detects north east neighbor of a cell" do
    detect_neighbor(1, 1, 1)
  end

  it "detects east neighbor of a cell" do
    detect_neighbor(1, 0, 1)
  end

  it "detects west neighbor of a cell" do
    detect_neighbor(-1, 0, 1)
  end

  it "detects south neighbor of a cell" do
    detect_neighbor(0, -1, 1)
  end

  it "detects south east neighbor of a cell" do
    detect_neighbor(1, -1, 1)
  end

  it "detects south west neighbor of a cell" do
    detect_neighbor(-1, -1, 1)
  end

  def detect_neighbor(x_pos, y_pos, expected_neighbor_count)
    cell = @subject.spawn_at(x_pos, y_pos)
    neighbors = get_neighbors 
    neighbors.count.should == expected_neighbor_count
  end

  def get_neighbors
    NeighborDetector.get_neighbors_of(@subject, world)
  end

end
