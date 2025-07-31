@unit.describe "Neospec::Report::Basic.call" do
  When "we have some results with no failures" do
    @suite = Neospec::Suite.new
    @results = Neospec::Results.new(suites: [@suite])

    spec_1 = Neospec::Spec.new(description: "a spec", block: -> {})
    spec_1.result.expectations = 3
    spec_1.result.start = 1
    spec_1.result.finish = 5
    @suite.specs << spec_1

    spec_2 = Neospec::Spec.new(description: "another spec", block: -> {})
    spec_2.result.expectations = 4
    spec_2.result.start = 6
    spec_2.result.finish = 9.5
    @suite.specs << spec_2
  end

  Then "it outputs information" do
    @output = TestOutputter.new
    Neospec::Report::Basic.call(@results, output: @output)

    expect(@output.calls.size).to_equal(1)
    expect(
      @output.calls.last
    ).to_equal(<<~STR)

      Finished in 7.5 seconds

      Results:
        Specs:\t2
        Expectations:\t7
    STR
  end

  When "we have some results with failures" do
    spec_3 = Neospec::Spec.new(description: "more spec", block: -> {})
    spec_3.result.expectations = 4
    spec_3.result.start = 6
    spec_3.result.finish = 9.5
    spec_3.result.failures << Neospec::Spec::Result::Failure.new(
      message: "oops!",
      stack: ["line 1", "line 2", "line 3", "line 4", "line 5", "line 6"]
    )
    spec_3.result.failures << Neospec::Spec::Result::Failure.new(
      message: "more oops!",
      stack: ["line 7", "line 8", "line 9", "line 10", "line 11", "line 12"]
    )
    @suite.specs << spec_3

    spec_4 = Neospec::Spec.new(description: "even more spec", block: -> {})
    spec_4.result.expectations = 2
    spec_4.result.start = 10
    spec_4.result.finish = 10.25
    spec_4.result.failures << Neospec::Spec::Result::Failure.new(
      message: "again, oops!",
      stack: ["line 13", "line 14", "line 15", "line 16", "line 17", "line 18"]
    )
    @suite.specs << spec_4
  end

  Then "it outputs information" do
    Neospec::Report::Basic.call(@results, output: @output)

    expect(@output.calls.size).to_equal(2)
    expect(@output.calls.last).to_equal(<<~STR)

      Finished in 11.25 seconds

      Results:
        Specs:\t4
        Expectations:\t13
        Failures:\t3

      Failures:
        #{Neospec::Color::BLUE}== more spec ==#{Neospec::Color::RESET}
          #{Neospec::Color::RED}-- oops! --#{Neospec::Color::RESET}
            > line 1
            > line 2
            > line 3
            > line 4
            > line 5

          #{Neospec::Color::RED}-- more oops! --#{Neospec::Color::RESET}
            > line 7
            > line 8
            > line 9
            > line 10
            > line 11

        #{Neospec::Color::BLUE}== even more spec ==#{Neospec::Color::RESET}
          #{Neospec::Color::RED}-- again, oops! --#{Neospec::Color::RESET}
            > line 13
            > line 14
            > line 15
            > line 16
            > line 17
    STR
  end
end

@unit.describe "Neospec::Report::Basic.formatted_duration" do
  Given "some durations" do
    hour = 60 * 60
    day = 24 * 60 * 60
    @milliseconds = 0.0012345
    @seconds = 10.322
    @minute = 61.5
    @minutes = 124
    @hour = hour + 62
    @hours = (2 * hour) + 122
    @day = day + hour + 63
    @days = (3 * day) + (4 * hour) + 120
  end

  Then "it nicely formats them" do
    expect(Neospec::Report::Basic.formatted_duration(@milliseconds)).to_equal("1.23 milliseconds")
    expect(Neospec::Report::Basic.formatted_duration(@seconds)).to_equal("10.32 seconds")
    expect(Neospec::Report::Basic.formatted_duration(@minute)).to_equal("1 minute 1 second")
    expect(Neospec::Report::Basic.formatted_duration(@minutes)).to_equal("2 minutes 4 seconds")
    expect(Neospec::Report::Basic.formatted_duration(@hour)).to_equal("1 hour 1 minute")
    expect(Neospec::Report::Basic.formatted_duration(@hours)).to_equal("2 hours 2 minutes")
    expect(Neospec::Report::Basic.formatted_duration(@day)).to_equal("1 day 1 hour")
    expect(Neospec::Report::Basic.formatted_duration(@days)).to_equal("3 days 4 hours")
  end
end
