# neospec

## Usage

Add `gem "neospec"` to your `Gemfile` and run `bundle install`.

Then it can be as simple as:

```ruby
require "neospec"

unit = Neospec::Suite.new
neospec = Neospec.new(suites: [unit])

unit.describe "An example test" do
  Given "apples are ripe" do
    @apples = :ripe
  end

  And "bananas are ripe" do
    @bananas = :ripe
  end

  Then "apples and bananas are as ripe as each other" do
    expect(@apples).to_equal(@bananas)
  end

  But "the bananas become TOO ripe" do
    @bananas = :over_ripe
  end

  Then "apples and bananas are now not as ripe as each other" do
    expect(@apples).not_to_equal(@bananas)
  end
end

neospec.run!
```

## Not yet implemented

- Early exit upon hitting a failure
- Expect errors
