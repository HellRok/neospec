@neospec.describe "Neospec::Expector#initialize" do
  Given "We create a new Neospec::Expector instance" do
    @result = Neospec::Spec::Result.new
    @logger = TestLogger.new

    @expect = Neospec::Expector.new(
      result: @result,
      actual: "actual",
      logger: @logger,
      stack: ["the stack"],
    )
  end

  Then "instance variables are set" do
    expect(@expect.instance_variable_get(:@result)).to_equal(@result)
    expect(@expect.instance_variable_get(:@actual)).to_equal("actual")
    expect(@expect.instance_variable_get(:@logger)).to_equal(@logger)
    expect(@expect.instance_variable_get(:@stack)).to_equal(["the stack"])
  end
end

@neospec.describe "Neospec::Expector#log" do
  Given "We create a new Neospec::Expector instance" do
    @result = Neospec::Spec::Result.new
    @logger = TestLogger.new

    @expect = Neospec::Expector.new(
      result: @result,
      actual: "actual",
      logger: @logger,
      stack: ["the stack"],
    )
  end

  When "#log is called" do
    @expect.log("the message", context: :the_context)
  end

  Then "the message is logged" do
    expect(@logger.calls.size).to_equal(1)
    expect(@logger.calls.first).to_equal(
      {
        message: "the message",
        context: :the_context,
        result: @result
      }
    )
  end
end

@neospec.describe "Neospec::Expector#succeeded" do
  Given "We create a new Neospec::Expector instance" do
    @result = Neospec::Spec::Result.new
    @logger = TestLogger.new

    @expect = Neospec::Expector.new(
      result: @result,
      actual: "actual",
      logger: @logger,
      stack: ["the stack"],
    )
  end

  When "#succeeded is called" do
    @expect.succeeded("the success message")
  end

  Then "the expectation is recorded" do
    expect(@result.expectations).to_equal(1)
  end

  And "the message is logged" do
    expect(@logger.calls.size).to_equal(1)
    expect(@logger.calls.first).to_equal(
      {
        message: "the success message",
        context: :expect,
        result: @result
      }
    )
  end
end

@neospec.describe "Neospec::Expector#failed" do
  Given "We create a new Neospec::Expector instance" do
    @result = Neospec::Spec::Result.new
    @logger = TestLogger.new

    @expect = Neospec::Expector.new(
      result: @result,
      actual: "actual",
      logger: @logger,
      stack: ["the stack"],
    )
  end

  When "#failed is called" do
    @expect.failed("the failure message")
  end

  Then "the failure is recorded" do
    expect(@result.failures.size).to_equal(1)
    expect(@result.failures.first.message).to_equal("Expected the failure message")
    expect(@result.failures.first.stack).to_equal(["the stack"])
  end

  And "the expectation is recorded" do
    expect(@result.expectations).to_equal(1)
  end

  And "the message is logged" do
    expect(@logger.calls.size).to_equal(1)
    expect(@logger.calls.first).to_equal(
      {
        message: "the failure message",
        context: :expect,
        result: @result
      }
    )
  end
end

@neospec.describe "Neospec::Expector expectations" do
  Given "We create a new Neospec::Expector instance" do
    @result = Neospec::Spec::Result.new
    @logger = TestLogger.new

    @expect = Neospec::Expector.new(
      result: @result,
      actual: "actual",
      logger: @logger,
      stack: ["the stack"],
    )
  end

  When "#to_equal is called with success" do
    @expect.to_equal("actual")
  end

  Then "it's recorded" do
    expect(@result.expectations).to_equal(1)
    expect(@result.failures.size).to_equal(0)
    expect(@logger.calls.size).to_equal(1)
    expect(@logger.calls.last[:message]).to_equal("to be equal")
  end

  When "#to_equal is called with failure" do
    @expect.to_equal("wrong")
  end

  Then "it's recorded" do
    expect(@result.expectations).to_equal(2)
    expect(@result.failures.size).to_equal(1)
    expect(@logger.calls.size).to_equal(2)
    expect(@logger.calls.last[:message]).to_equal("'wrong' to equal 'actual'")
  end

  When "#not_to_equal is called with success" do
    @expect.not_to_equal("wrong")
  end

  Then "it's recorded" do
    expect(@result.expectations).to_equal(3)
    expect(@result.failures.size).to_equal(1)
    expect(@logger.calls.size).to_equal(3)
    expect(@logger.calls.last[:message]).to_equal("not to be equal")
  end

  When "#to_equal is called with failure" do
    @expect.not_to_equal("actual")
  end

  Then "it's recorded" do
    expect(@result.expectations).to_equal(4)
    expect(@result.failures.size).to_equal(2)
    expect(@logger.calls.size).to_equal(4)
    expect(@logger.calls.last[:message]).to_equal("'actual' not to equal 'actual'")
  end

  When "#to_be_a is called with success" do
    @expect.to_be_a(String)
  end

  Then "it's recorded" do
    expect(@result.expectations).to_equal(5)
    expect(@result.failures.size).to_equal(2)
    expect(@logger.calls.size).to_equal(5)
    expect(@logger.calls.last[:message]).to_equal("to be a String")
  end

  When "#to_be_a is called with failure" do
    @expect.to_be_a(Array)
  end

  Then "it's recorded" do
    expect(@result.expectations).to_equal(6)
    expect(@result.failures.size).to_equal(3)
    expect(@logger.calls.size).to_equal(6)
    expect(@logger.calls.last[:message]).to_equal("'Array' to equal 'String'")
  end
end
