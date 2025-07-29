@unit.describe "Neospec#initialize" do
  Given "We create a new Neospec instance" do
    @unit = Neospec.new
  end

  Then "instance variables are set" do
    expect(@unit.suites).to_equal([])
    expect(@unit.logger).to_be_a(Neospec::Logger::Basic)
    expect(@unit.reporters).to_equal([Neospec::Report::Basic])
  end
end
