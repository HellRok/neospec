require "neospec/config"
require "neospec/results"
require "neospec/runner/basic"
require "neospec/spec"
require "neospec/suite"

class Neospec
  def initialize
    @config = Neospec::Config.new
    @suite = Neospec::Suite.new
    @results = nil
    @runner = Neospec::Runner::Basic.new
  end

  def describe(description, &block)
    @suite.specs << Neospec::Spec.new(description: description, block: block)
  end

  def run
    @results = @runner.run(
      config: @config,
      suite: @suite
    )
  end

  def exit
    exit 1 unless @results.successful?
  end
end
