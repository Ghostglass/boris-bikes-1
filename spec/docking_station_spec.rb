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
