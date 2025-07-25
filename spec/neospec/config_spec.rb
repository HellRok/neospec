$neospec.describe "Neospec::Config#initialize" do
  Given "We create a new Neospec::Config instance" do
    @config = Neospec::Config.new
  end

  Expect "@logger to be set" do
    @config.logger.is_a?(Neospec::Logger::Basic)
  end

  Expect "@runner to be set" do
    @config.runner.is_a?(Neospec::Runner::Basic)
  end
end

$neospec.describe "Neospec::Config#logger=" do
  Given "We have a Neospec::Config instance" do
    @config = Neospec::Config.new
  end

  Expect "@logger to be set" do
    @config.logger.is_a?(Neospec::Logger::Basic)
  end

  Then "we set a new logger" do
    @new_logger = Neospec::Logger::Basic.new
    @config.logger = @new_logger
  end

  Expect "@logger to be the new logger" do
    @config.logger == @new_logger
  end
end

$neospec.describe "Neospec::Config#runner=" do
  Given "We have a Neospec::Config instance" do
    @config = Neospec::Config.new
    @old_runner = @config.runner
  end

  Expect "@runner to be set" do
    @config.runner.is_a?(Neospec::Runner::Basic)
  end

  Then "we set a new runner" do
    @config.logger = Neospec::Runner::Basic
  end

  Expect "@runner to not be the old runner" do
    @config.runner == @old_runner
  end

  Expect "@runner.config to have been set too" do
    @config.runner.config == @config
  end
end
