@unit.describe "Neospec::Expector::ErrorExpectors#to_raise" do
  When "#to_raise is called with a block that raises with a message" do
    @expect = TestExpector.new(actual: -> { raise StandardError, "My cool error" })
    @expect.to_raise(StandardError, "My cool error")
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("to raise StandardError, 'My cool error'")
    expect(@expect.failure).to_be_nil
  end

  When "#to_raise is called with a block that raises with no message" do
    @expect = TestExpector.new(actual: -> { raise StandardError, "My cool error" })
    @expect.to_raise(StandardError)
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("to raise StandardError")
    expect(@expect.failure).to_be_nil
  end

  When "#to_raise is called with a block that doesn't raise" do
    @expect = TestExpector.new(actual: -> {})
    @expect.to_raise(StandardError)
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("to raise StandardError, but nothing was raised")
  end

  When "#to_raise is called with a block that raises with the right error but wrong message" do
    @expect = TestExpector.new(actual: -> { raise StandardError, "My cool error" })
    @expect.to_raise(StandardError, "Some other error")
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("to raise StandardError, 'Some other error', but got StandardError, 'My cool error'")
  end

  When "#to_raise is called with a block that raises with the wrong error" do
    @expect = TestExpector.new(actual: -> { raise ArgumentError, "The wrong args!" })
    @expect.to_raise(StandardError, "Some other error")
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("to raise StandardError, but got ArgumentError")
  end
end
