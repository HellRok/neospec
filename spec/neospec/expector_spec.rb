@unit.describe "Neospec::Expector" do
  expect(Neospec::Expector.included_modules).to_include(Neospec::Expector::EqualityExpectors)
  expect(Neospec::Expector.included_modules).to_include(Neospec::Expector::ErrorExpectors)
  expect(Neospec::Expector.included_modules).to_include(Neospec::Expector::InclusionExpectors)
end

@unit.describe "Neospec::Expector#initialize" do
  Given "We create a new Neospec::Expector instance" do
    @result = Neospec::Spec::Result.new
    @logger = TestLogger.new

    @expect = Neospec::Expector.new(
      result: @result,
      actual: "actual",
      logger: @logger,
      stack: ["the stack"]
    )
  end

  Then "instance variables are set" do
    expect(@expect.instance_variable_get(:@result)).to_equal(@result)
    expect(@expect.instance_variable_get(:@actual)).to_equal("actual")
    expect(@expect.instance_variable_get(:@logger)).to_equal(@logger)
    expect(@expect.instance_variable_get(:@stack)).to_equal(["the stack"])
  end
end

@unit.describe "Neospec::Expector#log" do
  Given "We create a new Neospec::Expector instance" do
    @result = Neospec::Spec::Result.new
    @logger = TestLogger.new

    @expect = Neospec::Expector.new(
      result: @result,
      actual: "actual",
      logger: @logger,
      stack: ["the stack"]
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

@unit.describe "Neospec::Expector#succeeded" do
  Given "We create a new Neospec::Expector instance" do
    @result = Neospec::Spec::Result.new
    @logger = TestLogger.new

    @expect = Neospec::Expector.new(
      result: @result,
      actual: "actual",
      logger: @logger,
      stack: ["the stack"]
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

@unit.describe "Neospec::Expector#failed" do
  Given "We create a new Neospec::Expector instance" do
    @result = Neospec::Spec::Result.new
    @logger = TestLogger.new

    @expect = Neospec::Expector.new(
      result: @result,
      actual: "actual",
      logger: @logger,
      stack: ["the stack"]
    )
  end

  When "#failed is called" do
    expect {
      @expect.failed("the failure message")
    }.to_raise(Neospec::Spec::Result::FailureEncounteredError)
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

@unit.describe "Neospec::Expector#actual" do
  Given "We create new Neospec::Expector instances with a value and a block" do
    @expect_with_value = Neospec::Expector.new(
      result: Neospec::Spec::Result.new,
      actual: "a basic value",
      logger: TestLogger.new,
      stack: ["the stack"]
    )

    @expect_with_block = Neospec::Expector.new(
      result: Neospec::Spec::Result.new,
      actual: -> { "a block" },
      logger: TestLogger.new,
      stack: ["the stack"]
    )
  end

  When "we return simple value" do
    expect(@expect_with_value.actual).to_equal("a basic value")
  end

  When "we return the block result" do
    expect(@expect_with_block.actual).to_equal("a block")
  end
end
