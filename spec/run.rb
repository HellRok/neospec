$: << "./lib"
$: << "./spec"

require "neospec"
require "support/test_logger"

$neospec = Neospec.new

require "neospec_spec"
require "neospec/config_spec"
require "neospec/results_spec"
require "neospec/runner/basic_spec"
require "neospec/spec_spec"
require "neospec/suite_spec"

$neospec.run

$neospec.exit
