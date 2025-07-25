$neospec.describe "Neospec#initialize" do
  Given "We create a new Neospec instance" do
    @neospec = Neospec.new
  end

  Expect "@config to be set" do
    @neospec.config.is_a?(Neospec::Config)
  end

  Expect "@suite to be set" do
    @neospec.suite.is_a?(Neospec::Suite)
  end

  Expect "@results to be set" do
    @neospec.results.is_a?(Neospec::Results)
  end
end
