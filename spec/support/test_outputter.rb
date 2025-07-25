class TestOutputter
  attr_accessor :calls

  def initialize
    @calls = []
  end

  def puts(message)
    @calls << message
  end
end
