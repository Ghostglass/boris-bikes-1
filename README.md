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

### Rspec test
```ruby
require 'docking_station'

describe DockingStation do
  # Test with information given to user
  it 'responds to release_bike' do
    expect(subject).to respond_to :release_bike
  end
  
  # Same test but on one line
  it { is_expected.to respond_to :release_bike }
end
```
