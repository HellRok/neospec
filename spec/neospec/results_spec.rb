@unit.describe "Neospec::Results#initialize" do
  Given "we create a new Neospec::Results instance" do
    @results = Neospec::Results.new(suites: "suites")
  end

  Then "instance variables are set" do
    expect(@results.suites).to_equal("suites")
  end
end

@unit.describe "Neospec::Results#specs" do
  Given "we create a new Neospec::Results instance" do
    @suite_1 = Neospec::Suite.new
    @suite_2 = Neospec::Suite.new
    @results = Neospec::Results.new(suites: [@suite_1, @suite_2])
  end

  And "we have defined specs" do
    @suite_1.describe "a spec" do
      expect(true).to_equal(true)
    end

    @suite_2.describe "a spec" do
      expect(true).to_equal(true)
    end

    @suite_2.describe "a spec" do
      expect(true).to_equal(true)
    end
  end

  Then "#specs contains all the suites specs" do
    expect(@results.specs.size).to_equal(3)
  end
end

@unit.describe "Neospec::Results#successful?" do
  Given "we create a new Neospec::Results instance" do
    @suite = Neospec::Suite.new
    @results = Neospec::Results.new(suites: [@suite])
  end

  And "we run a successful build" do
    @suite.describe "a spec" do
      expect(true).to_equal(true)
    end
    @suite.run(logger: TestLogger.new)
  end

  Then "it's successful" do
    expect(@results.successful?).to_equal(true)
  end

  But "we record an unsuccessful result" do
    @suite.describe "a failing spec" do
      expect(true).to_equal(false)
    end
    @suite.run(logger: TestLogger.new)
  end

  Then "it's not successful" do
    expect(@results.successful?).to_equal(false)
  end
end

@unit.describe "Neospec::Results#expectations" do
  Given "we create a new Neospec::Results instance" do
    @suite = Neospec::Suite.new
    @results = Neospec::Results.new(suites: [@suite])
  end

  Then "it starts at 0" do
    expect(@results.expectations).to_equal(0)
  end

  When "we run a build" do
    @suite.describe "a spec" do
      expect(true).to_equal(true)
      expect(true).to_equal(true)
      expect(true).to_equal(true)
    end

    @suite.describe "another spec" do
      expect(true).to_equal(true)
      expect(true).to_equal(true)
      expect(true).to_equal(true)
      expect(true).to_equal(true)
    end

    @suite.run(logger: TestLogger.new)
  end

  Then "it sums the expectations" do
    expect(@results.expectations).to_equal(7)
  end
end

@unit.describe "Neospec::Results#duration" do
  Given "we create a new Neospec::Results instance" do
    @suite = Neospec::Suite.new
    @results = Neospec::Results.new(suites: [@suite])
  end

  Then "it starts at 0" do
    expect(@results.duration).to_equal(0)
  end

  When "there are results" do
    spec_1 = Neospec::Spec.new(description: "a spec", block: -> {})
    spec_1.result.start = 1
    spec_1.result.finish = 3
    @suite.specs << spec_1

    spec_2 = Neospec::Spec.new(description: "another spec", block: -> {})
    spec_2.result.start = 4
    spec_2.result.finish = 9.5
    @suite.specs << spec_2
  end

  Then "it sums the durations" do
    expect(@results.duration).to_equal(7.5)
  end
end

@unit.describe "Neospec::Results#failures" do
  Given "we create a new Neospec::Results instance" do
    @suite = Neospec::Suite.new
    @results = Neospec::Results.new(suites: [@suite])
  end

  When "there are failures" do
    spec_1 = Neospec::Spec.new(description: "a spec", block: -> {})
    spec_1.result.failures << "failure 1"
    @suite.specs << spec_1

    spec_2 = Neospec::Spec.new(description: "another spec", block: -> {})
    spec_2.result.failures << "failure 2"
    spec_2.result.failures << "failure 3"
    @suite.specs << spec_2
  end

  Then "it combines all the failures" do
    expect(@results.failures).to_equal(
      [
        "failure 1",
        "failure 2",
        "failure 3"
      ]
    )
  end
end
