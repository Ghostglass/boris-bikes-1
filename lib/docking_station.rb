require_relative 'bike'

class DockingStation

  DEFAULT_CAPACITY = 20

  attr_reader :capacity

  def initialize(capacity=DEFAULT_CAPACITY)
      @docked = []
      @capacity = capacity
  end

  def release_bike
    raise "Empty dock" if empty?
    docked.each_with_index {|bike,index| docked.delete_at(index) ; return bike if bike.working? }
    raise "All bikes broken!"
  end

  def dock_bike(bike, working = true)
    raise "Full dock" if full?
    bike.working = false if !working
    docked << bike
  end

  private

  attr_reader :docked
  def full?
    docked.count >= capacity
  end

  def empty?
    docked.empty?
  end
end
