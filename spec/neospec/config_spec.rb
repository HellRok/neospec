@neospec.describe "Neospec::Config#initialize" do
  Given "We create a new Neospec::Config instance" do
    @config = Neospec::Config.new
  end

  Then "instance variables are set" do
    expect(@config.logger).to_be_a(Neospec::Logger::Basic)
    expect(@config.runner).to_be_a(Neospec::Runner::Basic)
  end
end

@neospec.describe "Neospec::Config#logger=" do
  Given "We have a Neospec::Config instance" do
    @config = Neospec::Config.new
  end

  Then "instance variables are set" do
    expect(@config.logger).to_be_a(Neospec::Logger::Basic)
  end

  When "we set a new logger" do
    @new_logger = Neospec::Logger::Basic.new
    @config.logger = @new_logger
  end

  Then "@logger to be the new logger" do
    expect(@config.logger).to_equal(@new_logger)
  end
end

@neospec.describe "Neospec::Config#runner=" do
  Given "We have a Neospec::Config instance" do
    @config = Neospec::Config.new
    @old_runner = @config.runner
  end

  Then "instance variables are set" do
    expect(@config.runner).to_be_a(Neospec::Runner::Basic)
  end

  When "we set a new runner" do
    @config.runner = Neospec::Runner::Basic
  end

  Then "we have updated @runner" do
    expect(@config.runner).not_to_equal(@old_runner)
    expect(@config.runner.config).to_equal(@config)
  end
end
