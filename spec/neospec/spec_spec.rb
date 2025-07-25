$neospec.describe "Neospec::Spec#initialize" do
  Given "We create a new Neospec::Spec instance" do
    @spec = Neospec::Spec.new(
      logger: "the logger",
      description: "the description",
      block: "the block"
    )
  end

  Expect "@result to be set" do
    @spec.result.is_a?(Neospec::Spec::Result)
  end

  Expect "@logger to be set" do
    @spec.logger == "the logger"
  end

  Expect "@description to be set" do
    @spec.description == "the description"
  end

  Expect "@block to be set" do
    @spec.block == "the block"
  end
end

$neospec.describe "Neospec::Spec#log" do
  Given "We create a new Neospec::Spec instance" do
    @test_logger = TestLogger.new
    @spec = Neospec::Spec.new(
      logger: @test_logger,
      description: "the description",
      block: "the block"
    )
  end

  When "log is called" do
    @spec.log("the message", context: "the context", result: "the result")
  end

  Expect "the logger to have received it" do
    @test_logger.calls == [
      {
        message: "the message",
        context: "the context",
        result: "the result"
      }
    ]
  end
end

$neospec.describe "Neospec::Spec#run" do
  Given "We create a new Neospec::Spec instance" do
    @test_logger = TestLogger.new

    $was_run = false

    @spec = Neospec::Spec.new(
      logger: @test_logger,
      description: "the description",
      block: -> { $was_run = true }
    )
  end

  When "the spec is run" do
    @spec.run
  end

  Expect "the block to have run" do
    $was_run
  end

ensure
  $was_run = nil
end

$neospec.describe "Neospec::Spec Commands" do
  Given "We create a new Neospec::Spec instance" do
    @test_logger = TestLogger.new

    $commands_run = []

    @spec = Neospec::Spec.new(
      logger: @test_logger,
      description: "the description",
      block: -> {
        Given("Given") { $commands_run << "Given" }
        And("And") { $commands_run << "And" }
        But("But") { $commands_run << "But" }
        When("When") { $commands_run << "When" }
        Then("Then") { $commands_run << "Then" }
      }
    )
  end

  When "the spec is run" do
    @spec.run
  end

  Expect "all commands were run" do
    $commands_run == Neospec::Spec::COMMANDS
  end

ensure
  $commands_run = nil
end

$neospec.describe "Neospec::Spec#Expect" do
  Given "We create a new Neospec::Spec instance" do
    @test_logger = TestLogger.new

    @spec = Neospec::Spec.new(
      logger: @test_logger,
      description: "the description",
      block: -> { }
    )
  end

  When "the block returns a thruthy value" do
    @spec.block = -> { Expect("first Expect") { true } }
    @spec.run
  end

  Expect("one expectation") { @spec.result.expectations == 1 }
  Expect("result to be successful") { @spec.result.successful? }

  When "the block returns a falsey value" do
    @spec.block = -> { Expect("second Expect") { false } }
    @spec.run
  end

  Expect("two expectations") { @spec.result.expectations == 2 }
  Expect("one failure") { @spec.result.failures.count == 1 }
  Expect("the failing line to be recorded") {
    @spec.result.failures.first == ""
  }
  Expect("result to be failure") { !@spec.result.successful? }
end
