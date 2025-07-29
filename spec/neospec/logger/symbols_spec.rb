@unit.describe "Neospec::Logger::Symbols#initialize" do
  Given "we create a new Neospec::Suite instance" do
    @output = TestOutputter.new
    @logger = Neospec::Logger::Symbols.new(output: @output, color: "color")
  end

  Then "instance variables are set" do
    expect(@logger.instance_variable_get(:@output)).to_equal(@output)
    expect(@logger.instance_variable_get(:@color)).to_equal("color")
  end
end

@unit.describe "Neospec::Logger::Symbols#log" do
  Given "we create a new Neospec::Suite instance" do
    @output = TestOutputter.new
    @logger = Neospec::Logger::Symbols.new(output: @output)
  end

  When "called with a describe context" do
    @logger.log("describe message", context: :describe)
  end

  Then "it has no output" do
    expect(@output.calls.size).to_equal(0)
  end

  When "called with a successful expect context" do
    @logger.log("success message", context: :expect, result: Neospec::Spec::Result.new)
  end

  Then "it outputs ✓" do
    expect(@output.calls.size).to_equal(1)
    expect(@output.calls.last).to_equal("#{Neospec::Color::GREEN}✓#{Neospec::Color::RESET}")
  end

  When "called with a failed expect context" do
    failure = Neospec::Spec::Result.new
    failure.failures << "oops"
    @logger.log("success message", context: :expect, result: failure)
  end

  Then "it outputs ✗" do
    expect(@output.calls.size).to_equal(2)
    expect(@output.calls.last).to_equal("#{Neospec::Color::RED}✗#{Neospec::Color::RESET}")
  end

  When "called with any other context" do
    @logger.log("given message", context: :Given)
  end

  Then "it has no output" do
    expect(@output.calls.size).to_equal(2)
  end
end
