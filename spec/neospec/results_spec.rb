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
