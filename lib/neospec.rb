require "neospec/color"
require "neospec/expector"
require "neospec/logger/basic"
require "neospec/logger/symbols"
require "neospec/report/basic"
require "neospec/results"
require "neospec/runner/basic"
require "neospec/spec"
require "neospec/spec/result"
require "neospec/spec/result/failure"
require "neospec/suite"
require "neospec/version"

class Neospec
  attr_accessor :logger, :suites, :reporters

  def initialize(
    suites: [],
    logger: Neospec::Logger::Basic.new,
    reporters: [Neospec::Report::Basic]
  )
    @suites = suites
    @logger = logger
    @reporters = reporters
  end

  def run!
    @suites.each { |suite|
      suite.run(logger: logger)
    }

    results = Neospec::Results.new(suites: @suites)

    reporters.each { |reporter| reporter.call(results) }

    exit 1 unless results.successful?
  end
end
