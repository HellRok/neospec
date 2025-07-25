$LOAD_PATH << "./lib"
require "neospec"

neospec = Neospec.new

neospec.describe "An example test" do
  Given "apples are ripe" do
    @apples = :ripe
  end

  And "bananas are ripe" do
    @bananas = :ripe
  end

  Expect "apples and bananas are as ripe as each other" do
    @apples == @bananas
  end

  But "the bananas become TOO ripe" do
    @bananas = :over_ripe
  end

  Expect "apples and bananas are now not as ripe as each other" do
    @apples == @bananas
  end
end

neospec.run

neospec.exit
