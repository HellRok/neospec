@neospec.describe "Neospec::Spec::Result#initialize" do
  Given "we create a new Neospec::Spec::Result instance" do
    @result = Neospec::Spec::Result.new
  end

  Then "instance variables are set" do
    expect(@result.expectations).to_equal(0)
    expect(@result.failures).to_equal([])
    expect(@result.start).to_equal(nil)
    expect(@result.finish).to_equal(nil)
  end
end

@neospec.describe "Neospec::Spec::Result#successful?" do
  Given "we create a new Neospec::Spec::Result instance with no failures" do
    @result = Neospec::Spec::Result.new
  end

  Then "it is successful" do
    expect(@result.successful?).to_equal(true)
  end

  But "if we record a failure" do
    @result.expectations = 1
    @result.failures << "a failure"
  end

  Then "it is not successful" do
    expect(@result.successful?).to_equal(false)
  end
end

@neospec.describe "Neospec::Spec::Result#finish!" do
  Given "we create a new Neospec::Spec::Result instance" do
    @result = Neospec::Spec::Result.new
  end

  When "we call #finish!" do
    @result.finish!
  end

  Then "a finish time is logged" do
    expect(@result.finish).to_be_a(Time)
  end
end

@neospec.describe "Neospec::Spec::Result#duration" do
  Given "we create a new Neospec::Spec::Result instance" do
    @result = Neospec::Spec::Result.new
  end

  Then "there is no duration" do
    expect(@result.duration).to_equal(nil)
  end

  When "there is a start and finish" do
    @result.start = 10
    @result.finish = 13.5
  end

  Then "there is a duration" do
    expect(@result.duration).to_equal(3.5)
  end
end
