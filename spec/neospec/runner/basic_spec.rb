@unit.describe "Neospec::Runner::Basic#run" do
  called = []

  Given "We create a new Neospec::Runner::Basic instance" do
    @runner = Neospec::Runner::Basic.new
  end

  When "we have a suite with hooks" do
    @suite = Neospec::Suite.new
    @suite.setup do
      called << "setup"
    end

    @suite.teardown do
      called << "teardown"
    end

    @suite.before do
      called << "before"
    end

    @suite.after do
      called << "after"
    end
  end

  And "there are specs defined" do
    @suite.describe "a spec" do
      called << "spec 1"
    end

    @suite.describe "another spec" do
      called << "spec 2"
    end
  end

  And "we call #run" do
    @runner.run(logger: TestLogger.new, suite: @suite)
  end

  Then "the specs are run" do
    expect(called).to_equal(
      [
        "setup",
        "before",
        "spec 1",
        "after",
        "before",
        "spec 2",
        "after",
        "teardown"
      ]
    )
  end
end
