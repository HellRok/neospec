# We do this because when we build an mgem we don't have access to 'require' so
# we use this constant to detect not to use 'require', so let's remove it here
# since we know we're not building in an mgem and can use 'require'.
Object.remove_const("MRUBY_VERSION") if Object.const_defined?("MRUBY_VERSION")

$: << "./lib"
$: << "./spec"

require "neospec"
require "support/test_expector"
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
require "neospec/expector/equality_expectors_spec"
require "neospec/expector/error_expectors_spec"
require "neospec/expector/inclusion_expectors_spec"
require "neospec/logger/basic_spec"
require "neospec/logger/symbols_spec"
require "neospec/report/basic_spec"
require "neospec/results_spec"
require "neospec/runner/basic_spec"
require "neospec/spec_spec"
require "neospec/spec/result_spec"
require "neospec/suite_spec"
require "neospec/version_spec"

neospec.run!
