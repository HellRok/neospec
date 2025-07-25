$neospec.describe "Neospec#initialize" do
  Given "We create a new Neospec instance" do
    @neospec = Neospec.new
  end

  Then "instance variables are set" do
    expect(@neospec.config).to_be_a(Neospec::Config)
    expect(@neospec.suite).to_be_a(Neospec::Suite)
    expect(@neospec.results).to_be_a(Neospec::Results)
  end
end
