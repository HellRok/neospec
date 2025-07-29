@unit.describe "Neospec::Runner::Basic#run" do
  specs_run = []

  Given "We create a new Neospec::Runner::Basic instance" do
    @runner = Neospec::Runner::Basic.new
  end

  When "there are specs defined" do
    @suite = Neospec::Suite.new
    @suite.specs << Neospec::Spec.new(
      description: "",
      block: -> { specs_run << "spec 1" }
    )
    @suite.specs << Neospec::Spec.new(
      description: "",
      block: -> { specs_run << "spec 2" }
    )
  end

  And "we call #run" do
    @runner.run(logger: TestLogger.new, suite: @suite)
  end

  Then "the specs are run" do
    expect(specs_run).to_equal(["spec 1", "spec 2"])
  end
end
