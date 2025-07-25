@neospec.describe "Neospec::Suite#initialize" do
  Given "we create a new Neospec::Suite instance" do
    @suite = Neospec::Suite.new
  end

  Then "instance variables are set" do
    expect(@suite.specs).to_equal([])
  end
end
