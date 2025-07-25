$neospec.describe "Neospec::Runner::Basic#initialize" do
  Given "We create a new Neospec::Runner::Basic instance" do
    @runner = Neospec::Runner::Basic.new(config: Neospec::Config.new)
  end

  Expect "@config to be set" do
    @runner.config.is_a?(Neospec::Config)
  end

  Expect "@results to be set" do
    @runner.results.is_a?(Neospec::Results)
  end
end
