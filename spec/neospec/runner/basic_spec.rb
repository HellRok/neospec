$neospec.describe "Neospec::Runner::Basic#initialize" do
  Given "We create a new Neospec::Runner::Basic instance" do
    @runner = Neospec::Runner::Basic.new(config: Neospec::Config.new)
  end

  Then "instance variables are set" do
    expect(@runner.config).to_be_a(Neospec::Config)
    expect(@runner.results).to_be_a(Neospec::Results)
  end
end

$neospec.describe "Neospec::Runner::Basic#run" do
  specs_run = []

  Given "We create a new Neospec::Runner::Basic instance" do
    @runner = Neospec::Runner::Basic.new(config: Neospec::Config.new)
  end

  When "there are specs defined" do
    @suite = Neospec::Suite.new
    @suite.specs << Neospec::Spec.new(
      description: "",
      logger: TestLogger.new,
      block: -> { specs_run << "spec 1" }
    )
    @suite.specs << Neospec::Spec.new(
      description: "",
      logger: TestLogger.new,
      block: -> { specs_run << "spec 2" }
    )
  end

  And "we call #run" do
    @runner.run(suite: @suite)
  end

  Then "the specs are run" do
    expect(specs_run).to_equal(["spec 1", "spec 2"])
  end

  And "the results are recorded" do
    expect(@runner.results.specs.size).to_equal(2)
  end
end
