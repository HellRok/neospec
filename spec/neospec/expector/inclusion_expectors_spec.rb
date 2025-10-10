@unit.describe "Neospec::Expector::InclusionExpectors#to_include" do
  When "#to_include is called with success" do
    @expect = TestExpector.new(actual: ["actual"])
    @expect.to_include("actual")
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("to include 'actual'")
    expect(@expect.failure).to_be_nil
  end

  When "#to_include is called with failure" do
    @expect = TestExpector.new(actual: ["actual"])
    @expect.to_include("something")
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("[\"actual\"] to include 'something'")
  end
end

@unit.describe "Neospec::Expector::InclusionExpectors#not_to_include" do
  When "#not_to_include is called with success" do
    @expect = TestExpector.new(actual: ["actual"])
    @expect.not_to_include("something")
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("not to include 'something'")
    expect(@expect.failure).to_be_nil
  end

  When "#not_to_include is called with failure" do
    @expect = TestExpector.new(actual: ["actual"])
    @expect.not_to_include("actual")
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("[\"actual\"] not to include 'actual'")
  end
end

@unit.describe "Neospec::Expector::InclusionExpectors#to_be_in" do
  When "#to_be_in is called with success" do
    @expect = TestExpector.new(actual: "actual")
    @expect.to_be_in(["actual"])
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("to be in [\"actual\"]")
    expect(@expect.failure).to_be_nil
  end

  When "#to_be_in is called with failure" do
    @expect = TestExpector.new(actual: "actual")
    @expect.to_be_in(["something"])
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("'actual' to be in [\"something\"]")
  end
end

@unit.describe "Neospec::Expector::InclusionExpectors#not_to_be_in" do
  When "#not_to_be_in is called with success" do
    @expect = TestExpector.new(actual: "actual")
    @expect.not_to_be_in(["something"])
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("not to be in [\"something\"]")
    expect(@expect.failure).to_be_nil
  end

  When "#not_to_be_in is called with failure" do
    @expect = TestExpector.new(actual: "actual")
    @expect.not_to_be_in(["actual"])
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("'actual' not to be in [\"actual\"]")
  end
end
