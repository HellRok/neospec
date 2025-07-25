$LOAD_PATH << "./lib"
require "neospec"

neospec = Neospec.new

neospec.describe "an example test" do
  Given "apples are ripe" do
    @apples = :ripe
  end

  And "bananas are ripe" do
    @bananas = :ripe
  end

  Expect "apples and bananas are as ripe as each other" do
    @apples == @bananas
  end
end

neospec.run

neospec.exit
