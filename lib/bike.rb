class Bike

  attr_accessor :working

  def initialize(work=true)
    @working = work
  end

  def working?
    working
  end
end
