@unit.describe "Neospec::Spec#initialize" do
  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: "the block"
    )
  end

  Then "instance variables are set" do
    expect(@spec.instance_variable_get(:@__result)).to_be_a(Neospec::Spec::Result)

    expect(@spec.instance_variable_get(:@__description)).to_equal("the description")
    expect(@spec.instance_variable_get(:@__block)).to_equal("the block")
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

@unit.describe "Neospec::Spec#run with errors" do
  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: -> { raise StandardError, "whoops!" }
    )
  end

  When "the spec is run" do
    @spec.run(logger: TestLogger.new)
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
end

@unit.describe "Neospec::Spec Commands" do
  commands_run = []

  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      description: "the description",
      block: -> {
        Given("Given") { commands_run << "Given" }
        And("And") { commands_run << "And" }
        But("But") { commands_run << "But" }
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

  Then "we can call #expect and get an Expector" do
    expectation = @spec.expect("something")
    expect(expectation).to_be_a(Neospec::Expector)
  end
end
