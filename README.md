#Boris Bikes

## Outline
Let's go back several years, to the days when there were no Boris Bikes. Imagine that you're a junior developer (that was easy). Transport for London, the body responsible for delivery of a new bike system, come to you with a plan: a network of docking stations and bikes that anyone can use. They want you to build a program that will emulate all the docking stations, bikes, and infrastructure (repair staff, and so on) required to make their dream a reality.

## User Story 1 - Get bike from docking station
We we're given a user story that we had to transform into a Domain Model. As in all TDD we created a test for a feature that we wanted to manipulate.

### User Story
```
As a person,
So that I can use a bike,
I'd like to get a bike from a docking station.
```

### DockingStation Rspec file
```ruby
require "docking_station"

describe DockingStation do
  # Create bike double and allow it to access variable "working"
  let(:bike) { double :bike, :working= => true, working?: false}

  # TEST: Release a bike
  it { is_expected.to respond_to :release_bike }

  # TEST: Release only a working bike
  it 'releases a bike if working' do
    allow(bike).to receive(:working?).and_return(true)
    subject.dock_bike(bike)
    expect(subject.release_bike).to be_working
  end

  # TEST: Check method dock_bike responds to 1 argument
  it { is_expected.to respond_to(:dock_bike).with(1).argument }

  # TEST: Dock a bike successfully
  it 'docks something' do
    allow(bike).to receive(:working?)
    expect(subject.dock_bike(bike)).to eq [bike]
  end

  # TEST: Fill docking station up and check for full error
  it "gives an error when docking station is full" do
    DockingStation::DEFAULT_CAPACITY.times { subject.dock_bike(bike) }
    expect{subject.dock_bike(bike)}.to raise_error 'Full dock'
  end

  # TEST: Dock a bike then release the same bike
  it 'releases a bike' do
    allow(bike).to receive(:working?).and_return(true)
    subject.dock_bike(bike)
    expect(subject.release_bike).to eq bike
  end

  # TEST: Test for error if docking station is empty
  it 'raises an error if dock empty' do
    expect {subject.release_bike}.to raise_error 'Empty dock'
  end

  # Test different size docking stations
  it 'Allow user to set capacity of docking station' do
    # Create a new station with 50 bikes and test
    num = 50
    station = DockingStation.new(num)
    expect(station.capacity).to eq num

    # Create a default station using the DEFAULT_CAPACITY constant
    station = DockingStation.new
    expect(station.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end
end
```

### Bike Rspec file
```ruby
require 'bike'

describe Bike do
  # TEST: check to see if we can respond to method working?
  it {is_expected.to respond_to :working?}
end
```

### Docking Station Ruby code
```ruby
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
```

### Bike Station Ruby code
```ruby
class Bike

  attr_accessor :working

  def initialize(work=true)
    @working = work
  end

  def working?
    working
  end
end
```
