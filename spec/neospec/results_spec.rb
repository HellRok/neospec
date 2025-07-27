@neospec.describe "Neospec::Results#initialize" do
  Given "we create a new Neospec::Results instance" do
    @results = Neospec::Results.new
  end

  Then "instance variables are set" do
    expect(@results.specs).to_equal([])
  end
end

@neospec.describe "Neospec::Results#record" do
  Given "we create a new Neospec::Results instance" do
    @results = Neospec::Results.new
  end

  And "we record a result" do
    @results.record("result")
  end

  Then "@specs is appended" do
    expect(@results.specs).to_equal(["result"])
  end
end

@neospec.describe "Neospec::Results#<<" do
  Given "we create a new Neospec::Results instance" do
    @results = Neospec::Results.new
  end

  And "we record a result" do
    @results.record("result")
  end

  And "we append another Neospec::Results" do
    other_results = Neospec::Results.new
    other_results.record("another result")

    @results << other_results
  end

  Then "@specs contains all the results" do
    expect(@results.specs).to_equal(["result", "another result"])
  end
end

@neospec.describe "Neospec::Results#successful?" do
  Given "we create a new Neospec::Results instance" do
    @results = Neospec::Results.new
  end

  And "we record a successful result" do
    @results.record(Neospec::Spec::Result.new)
  end

  Then "it's successful" do
    expect(@results.successful?).to_equal(true)
  end

  But "we record an unsuccessful result" do
    result = Neospec::Spec::Result.new
    result.failures << "failure"
    @results.record(result)
  end

  Then "it's not successful" do
    expect(@results.successful?).to_equal(false)
  end
end

@neospec.describe "Neospec::Results#expectations" do
  Given "we create a new Neospec::Results instance" do
    @results = Neospec::Results.new
  end

  Then "it starts at 0" do
    expect(@results.expectations).to_equal(0)
  end

  When "there are expectations" do
    result = Neospec::Spec::Result.new
    result.expectations = 4
    @results.record(result)

    result = Neospec::Spec::Result.new
    result.expectations = 8
    @results.record(result)
  end

  Then "it sums the expectations" do
    expect(@results.expectations).to_equal(12)
  end
end

@neospec.describe "Neospec::Results#duration" do
  Given "we create a new Neospec::Results instance" do
    @results = Neospec::Results.new
  end

  Then "it starts at 0" do
    expect(@results.duration).to_equal(0)
  end

  When "there are results" do
    result = Neospec::Spec::Result.new
    result.start = 1
    result.finish = 3
    @results.record(result)

    result = Neospec::Spec::Result.new
    result.start = 4
    result.finish = 9.5
    @results.record(result)
  end

  Then "it sums the durations" do
    expect(@results.duration).to_equal(7.5)
  end
end

@neospec.describe "Neospec::Results#failures" do
  Given "we create a new Neospec::Results instance" do
    @results = Neospec::Results.new
  end

  When "there are failures" do
    result = Neospec::Spec::Result.new
    result.failures << "failure 1"
    @results.record(result)

    result = Neospec::Spec::Result.new
    result.failures << "failure 2"
    result.failures << "failure 3"
    @results.record(result)
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
