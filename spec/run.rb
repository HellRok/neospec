$: << "./lib"
$: << "./spec"

require "neospec"
require "support/test_logger"
require "support/test_outputter"

@unit = Neospec::Suite.new(
  runner: Neospec::Runner::Basic.new
)

neospec = Neospec.new(
  logger: Neospec::Logger::Basic.new,
  reporters: [Neospec::Report::Basic],
  suites: [@unit]
)

require "neospec_spec"
require "neospec/expector_spec"
require "neospec/logger/basic_spec"
require "neospec/logger/symbols_spec"
require "neospec/report/basic_spec"
require "neospec/results_spec"
require "neospec/runner/basic_spec"
require "neospec/spec_spec"
require "neospec/spec/result_spec"
require "neospec/suite_spec"

neospec.run!
