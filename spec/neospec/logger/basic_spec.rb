$neospec.describe "Neospec::Logger::Basic#initialize" do
  Given "we create a new Neospec::Suite instance" do
    @output = TestOutputter.new
    @logger = Neospec::Logger::Basic.new(output: @output)
  end

  Then "instance variables are set" do
    expect(@logger.output).to_equal(@output)
  end
end

$neospec.describe "Neospec::Logger::Basic#log" do
  Given "we create a new Neospec::Suite instance" do
    @output = TestOutputter.new
    @logger = Neospec::Logger::Basic.new(output: @output)
  end

  When "called with a describe context" do
    @logger.log("describe message", context: :describe)
  end

  Then "it outputs with no indent" do
    expect(@output.calls.size).to_equal(1)
    expect(@output.calls.last).to_equal("describe message")
  end

  When "called with a successful expect context" do
    @logger.log("success message", context: :expect, result: Neospec::Spec::Result.new)
  end

  Then "it outputs with indent and ✓" do
    expect(@output.calls.size).to_equal(2)
    expect(@output.calls.last).to_equal("    ✓ expect success message")
  end

  When "called with a failed expect context" do
    failure = Neospec::Spec::Result.new
    failure.failures << "oops"
    @logger.log("success message", context: :expect, result: failure)
  end

  Then "it outputs with indent and ✗" do
    expect(@output.calls.size).to_equal(3)
    expect(@output.calls.last).to_equal("    ✗ expect success message")
  end

  When "called with any other context" do
    @logger.log("given message", context: :Given)
  end

  Then "it outputs with some indent" do
    expect(@output.calls.size).to_equal(4)
    expect(@output.calls.last).to_equal("  Given given message")
  end
end
