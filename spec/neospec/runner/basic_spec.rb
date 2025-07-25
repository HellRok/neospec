$neospec.describe "Neospec::Runner::Basic#initialize" do
  Given "We create a new Neospec::Runner::Basic instance" do
    @runner = Neospec::Runner::Basic.new(config: Neospec::Config.new)
  end

  Then "instance variables are set" do
    expect(@runner.config).to_be_a(Neospec::Config)
    expect(@runner.results).to_be_a(Neospec::Results)
  end
end
