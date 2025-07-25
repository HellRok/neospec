class Neospec
  class Config
    attr_reader :runner
    attr_accessor :logger

    def initialize
      @logger = Neospec::Logger::Basic.new
      @runner = Neospec::Runner::Basic.new(config: self)
    end

    def runner=(runner_class)
      @runner = runner_class.new(config: self)
    end
  end
end
