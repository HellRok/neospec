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
