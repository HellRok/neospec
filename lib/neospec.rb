require "neospec/config"
require "neospec/logger/basic"
require "neospec/result"
require "neospec/results"
require "neospec/runner/basic"
require "neospec/spec"
require "neospec/suite"

class Neospec
  def initialize
    @config = Neospec::Config.new
    @suite = Neospec::Suite.new
    @runner = Neospec::Runner::Basic.new
    @logger = Neospec::Logger::Basic.new

    @results = Neospec::Results.new
  end

  def describe(description, &block)
    @suite.specs << Neospec::Spec.new(
      logger: @logger,
      description: description,
      block: block,
    )
  end

  def run
    @results << @runner.run(config: @config, suite: @suite)
  end

  def exit
    Kernel.exit 1 unless @results.successful?
  end
end
