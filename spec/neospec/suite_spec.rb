@unit.describe "Neospec::Suite#initialize" do
  Given "we create a new Neospec::Suite instance" do
    @suite = Neospec::Suite.new
  end

  Then "instance variables are set" do
    expect(@suite.runner).to_be_a(Neospec::Runner::Basic)
    expect(@suite.specs).to_equal([])
  end

  When "we create a new Neospec::Suite instance with a runner" do
    @runner = Neospec::Runner::Basic.new
    @suite = Neospec::Suite.new(runner: @runner)
  end

  Then "instance variables are set" do
    expect(@suite.runner).to_equal(@runner)
    expect(@suite.specs).to_equal([])
  end
end

@unit.describe "Neospec::Suite#describe" do
  Given "we create a new Neospec::Suite instance" do
    @suite = Neospec::Suite.new
  end

  When "we call #describe" do
    @suite.describe "a spec" do
    end
  end

  Then "it's recorded in #specs" do
    expect(@suite.specs.size).to_equal(1)
    expect(@suite.specs.first.description).to_equal("a spec")
  end
end

@unit.describe "Neospec::Suite#run" do
  called = []

  Given "we create a new Neospec::Suite instance" do
    @suite = Neospec::Suite.new
  end

  And "it has specs" do
    @suite.describe "a spec" do
      called << "spec 1"
    end

    @suite.describe "another spec" do
      called << "spec 2"
    end
  end

  When "we call #run" do
    @suite.run(logger: TestLogger.new)
  end

  Then "it ran the spec" do
    expect(called).to_equal(["spec 1", "spec 2"])
  end
end
