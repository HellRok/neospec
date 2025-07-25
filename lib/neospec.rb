require "neospec/config"
require "neospec/expector"
require "neospec/logger/basic"
require "neospec/results"
require "neospec/runner/basic"
require "neospec/spec"
require "neospec/spec/result"
require "neospec/spec/result/failure"
require "neospec/suite"

class Neospec
  attr_accessor :config, :suite, :results

  def initialize
    @config = Neospec::Config.new
    @suite = Neospec::Suite.new

    @results = Neospec::Results.new
  end

  def describe(description, &block)
    @suite.specs << Neospec::Spec.new(
      logger: logger,
      description: description,
      block: block
    )
  end

  def run
    runner.run(suite: @suite)
    @results << runner.results
  end

  def logger
    @config.logger
  end

  def runner
    @config.runner
  end

  def exit
    Kernel.exit 1 unless @results.successful?
  end
end
