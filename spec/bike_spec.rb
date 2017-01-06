require 'bike'

describe Bike do
  # TEST: check to see if we can respond to method working?
  it {is_expected.to respond_to :working?}
end
