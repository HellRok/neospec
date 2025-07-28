class TestOutputter
  attr_accessor :calls

  def initialize
    @calls = []
  end

  def puts(message)
    write "#{message}\n"
  end

  def write(message)
    @calls << message
  end
end
