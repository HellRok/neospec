$: << "./lib"
$: << "./spec"

require "neospec"
require "support/test_logger"

$neospec = Neospec.new

$neospec.describe "An example test" do
  Given "apples are ripe" do
    @apples = :ripe
  end

  And "bananas are ripe" do
    @bananas = :ripe
  end

  Then "apples and bananas are as ripe as each other" do
    expect(@apples).to_equal(@bananas)
  end

  But "the bananas become TOO ripe" do
    @bananas = :over_ripe
  end

  Then "apples and bananas are now not as ripe as each other" do
    expect(@apples).not_to_equal(@bananas)
  end
end

require "neospec_spec"
require "neospec/config_spec"
require "neospec/runner/basic_spec"
require "neospec/spec_spec"

$neospec.run

$neospec.exit
