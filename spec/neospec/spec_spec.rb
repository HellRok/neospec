@unit.describe "Neospec::Spec#initialize" do
  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: "the block",
      stack: ["file_name:line_number"]
    )
  end

  Then "instance variables are set" do
    expect(@spec.instance_variable_get(:@__result)).to_be_a(Neospec::Spec::Result)

    expect(@spec.instance_variable_get(:@__description)).to_equal("the description")
    expect(@spec.instance_variable_get(:@__block)).to_equal("the block")
    expect(@spec.instance_variable_get(:@__stack)).to_equal(["file_name:line_number"])
  end
end

@unit.describe "Neospec::Spec#location" do
  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: "the block",
      stack: ["file_name:line_number"]
    )
  end

  Then "we have a location" do
    expect(@spec.location).to_equal("file_name:line_number")
  end
end

@unit.describe "Neospec::Spec#file_name" do
  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: "the block",
      stack: ["file_name:line_number"]
    )
  end

  Then "we have a filename" do
    expect(@spec.file_name).to_equal("file_name")
  end
end

@unit.describe "Neospec::Spec#log" do
  Given "We create a new Neospec::Spec instance" do
    @logger = TestLogger.new
    @spec = Neospec::Spec.new(
      description: "the description",
      block: "the block"
    )
    @spec.instance_variable_set(:@__logger, @logger)
  end

  When "log is called" do
    @spec.log("the message", context: "the context", result: "the result")
  end

  Then "the logger receives the call" do
    expect(@logger.calls.size).to_equal(1)
    expect(@logger.calls.first).to_equal(
      {
        message: "the message",
        context: "the context",
        result: "the result"
      }
    )
  end
end

@unit.describe "Neospec::Spec#run" do
  was_run = false

  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: -> { was_run = true }
    )
  end

  When "the spec is run" do
    @spec.run(logger: TestLogger.new)
  end

  Then "the block was run" do
    expect(was_run).to_equal(true)
  end

  And "the result timing was updated" do
    expect(@spec.result.finish).to_be_a(Time)
  end
end

@unit.describe "Neospec::Spec#run with failures" do
  called = []

  Given "We create a new Neospec::Spec instance with a failure" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: -> {
        expect(true).to_equal(true)
        called << "start"
        expect(true).to_equal(false)
        called << "end"
      }
    )
  end

  When "the spec is run" do
    @logger = TestLogger.new
    @spec.run(logger: @logger)
  end

  Then "only some of the block was run" do
    expect(called).to_equal(["start"])
  end

  And "the result was recorded" do
    expect(@spec.result.finish).to_be_a(Time)
    expect(@spec.result.expectations).to_equal(2)
    expect(@spec.result.failures.size).to_equal(1)
  end

  And "it was logged" do
    expect(@logger.calls.size).to_equal(3)
    expect(@logger.calls.map { |call| call[:message] }).to_equal([
      "the description",
      "to be equal",
      "'false' to equal 'true'"
    ])
  end
end

@unit.describe "Neospec::Spec#run with errors" do
  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: -> { raise StandardError, "whoops!" }
    )
  end

  When "the spec is run" do
    @logger = TestLogger.new
    @spec.run(logger: @logger)
  end

  Then "the spec is considered failed" do
    expect(@spec.successful?).to_equal(false)
    expect(@spec.failures.size).to_equal(1)
    expect(@spec.failures.first.message).to_equal("Raised StandardError, 'whoops!'")
    expect(@spec.failures.first.stack).not_to_equal([])
  end

  And "the timing is persisted" do
    expect(@spec.result.start).to_be_a(Time)
    expect(@spec.result.finish).to_be_a(Time)
  end

  And "it was logged" do
    expect(@logger.calls.size).to_equal(2)
    expect(@logger.calls.map { |call| call[:message] }).to_equal([
      "the description",
      "raised StandardError"
    ])
  end
end

@unit.describe "Neospec::Spec::COMMANDS" do
  commands_run = []

  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: -> {
        Given("Given") { commands_run << "Given" }
        And("And") { commands_run << "And" }
        But("But") { commands_run << "But" }
        But("Or") { commands_run << "Or" }
        When("When") { commands_run << "When" }
        Then("Then") { commands_run << "Then" }
      }
    )
  end

  When "the spec is run" do
    @spec.run(logger: TestLogger.new)
  end

  Then "all commands were run" do
    expect(commands_run).to_equal(Neospec::Spec::COMMANDS)
  end
end

@unit.describe "Neospec::Spec#expect" do
  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: -> {}
    )
  end

  When "we can call #expect with a value" do
    @expectation = @spec.expect("something")
  end

  Then "an expector is setup" do
    expect(@expectation).to_be_a(Neospec::Expector)
    expect(@expectation.actual).to_equal("something")
  end

  When "we can call #expect with a block" do
    @expectation = @spec.expect do
      "a block"
    end
  end

  Then "an expector is setup" do
    expect(@expectation).to_be_a(Neospec::Expector)
    expect(@expectation.actual).to_equal("a block")
  end

  When "we can call #expect with a block and value" do
    expect {
      @spec.expect("something") do
        "a block"
      end
    }.to_raise(ArgumentError, "Can't specify value AND pass a block")
  end
end
