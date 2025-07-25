class Neospec
  class Config
    attr_accessor :logger, :runner

    def initialize
      @logger = Neospec::Logger::Basic.new
      @runner = Neospec::Runner::Basic.new(config: self)
    end
  end
end
