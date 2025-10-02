@unit.describe "Neospec::Expector::EqualityExpectors#to_be_nil" do
  When "#to_be_nil is called with success" do
    @expect = TestExpector.new(actual: nil)
    @expect.to_be_nil
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("to be nil")
    expect(@expect.failure).to_be_nil
  end

  When "#to_be_nil is called with failure" do
    @expect = TestExpector.new(actual: "actual")
    @expect.to_be_nil
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("'actual' to be nil")
  end
end

@unit.describe "Neospec::Expector::EqualityExpectors#to_be_empty" do
  When "#to_be_empty is called with success" do
    @expect = TestExpector.new(actual: [])
    @expect.to_be_empty
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("to be empty")
    expect(@expect.failure).to_be_nil
  end

  When "#to_be_empty is called with failure" do
    @expect = TestExpector.new(actual: ["actual"])
    @expect.to_be_empty
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("[\"actual\"] to be empty")
  end
end

@unit.describe "Neospec::Expector::EqualityExpectors#to_equal" do
  When "#to_equal is called with success" do
    @expect = TestExpector.new(actual: "actual")
    @expect.to_equal("actual")
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("to be equal")
    expect(@expect.failure).to_be_nil
  end

  When "#to_equal is called with failure" do
    @expect = TestExpector.new(actual: "actual")
    @expect.to_equal("something")
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("'something' to equal 'actual'")
  end
end

@unit.describe "Neospec::Expector::EqualityExpectors#not_to_equal" do
  When "#not_to_equal is called with success" do
    @expect = TestExpector.new(actual: "actual")
    @expect.not_to_equal("something")
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("not to be equal")
    expect(@expect.failure).to_be_nil
  end

  When "#not_to_equal is called with failure" do
    @expect = TestExpector.new(actual: "actual")
    @expect.not_to_equal("actual")
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("not to equal 'actual'")
  end
end

@unit.describe "Neospec::Expector::EqualityExpectors#to_be_a" do
  When "#to_be_a is called with the class" do
    @expect = TestExpector.new(actual: "actual")
    @expect.to_be_a(String)
  end

  Then "it's successful" do
    expect(@expect.success).to_equal("to be a String")
    expect(@expect.failure).to_be_nil
  end

  When "#to_be_a is called with a parent" do
    @expect = TestExpector.new(actual: "actual")
    @expect.to_be_a(Object)
  end

  Then "it's successful" do
    expect(@expect.success).to_equal("to be a Object")
    expect(@expect.failure).to_be_nil
  end

  When "#to_be_a is called with a wrong class" do
    @expect = TestExpector.new(actual: "actual")
    @expect.to_be_a(Neospec)
  end

  Then "it's failed" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("String to be a Neospec")
  end
end

@unit.describe "Neospec::Expector::EqualityExpectors#to_be_true" do
  When "#to_be_true is called with success" do
    @expect = TestExpector.new(actual: true)
    @expect.to_be_true
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("to be true")
    expect(@expect.failure).to_be_nil
  end

  When "#to_be_true is called with failure" do
    @expect = TestExpector.new(actual: false)
    @expect.to_be_true
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("'false' to be true")
  end
end

@unit.describe "Neospec::Expector::EqualityExpectors#to_be_false" do
  When "#to_be_true is called with success" do
    @expect = TestExpector.new(actual: false)
    @expect.to_be_false
  end

  Then "it's recorded" do
    expect(@expect.success).to_equal("to be false")
    expect(@expect.failure).to_be_nil
  end

  When "#to_be_false is called with failure" do
    @expect = TestExpector.new(actual: true)
    @expect.to_be_false
  end

  Then "it's recorded" do
    expect(@expect.success).to_be_nil
    expect(@expect.failure).to_equal("'true' to be false")
  end
end
