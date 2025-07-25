class TestLogger
  attr_accessor :calls

  def initialize
    @calls = []
  end

  def log(message, context: nil, result: nil)
    @calls << {
      message: message,
      context: context,
      result: result
    }
  end
end
