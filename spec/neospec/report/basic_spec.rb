@neospec.describe "Neospec::Report::Basic.call" do
  When "we have some results with no failures" do
    @results = Neospec::Results.new

    result_1 = Neospec::Spec::Result.new
    result_1.expectations = 3
    result_1.start = 1
    result_1.finish = 5
    @results.record(result_1)

    result_2 = Neospec::Spec::Result.new
    result_2.expectations = 4
    result_2.start = 6
    result_2.finish = 9.5
    @results.record(result_2)
  end

  Then "it outputs information" do
    @output = TestOutputter.new
    Neospec::Report::Basic.call(
      @results,
      output: @output
    )

    expect(@output.calls.size).to_equal(1)
    expect(
      @output.calls.last
    ).to_equal(<<~STR.chomp)

      Finished in 7.5 seconds

      Results:
        Specs:\t2
        Expectations:\t7
    STR
  end

  When "we have some results with failures" do
    @results = Neospec::Results.new

    result_1 = Neospec::Spec::Result.new
    result_1.expectations = 9
    result_1.start = 1
    result_1.finish = 5
    @results.record(result_1)

    result_2 = Neospec::Spec::Result.new
    result_2.expectations = 4
    result_2.start = 6
    result_2.finish = 9.5
    result_2.failures << Neospec::Spec::Result::Failure.new(
      message: "oops!",
      stack: ["line 1", "line 2", "line 3", "line 4", "line 5", "line 6"]
    )
    @results.record(result_2)

    result_3 = Neospec::Spec::Result.new
    result_3.expectations = 2
    result_3.start = 10
    result_3.finish = 10.25
    result_3.failures << Neospec::Spec::Result::Failure.new(
      message: "again, oops!",
      stack: ["line 7", "line 8", "line 9", "line 10", "line 11", "line 12"]
    )
    @results.record(result_3)
  end

  Then "it outputs information" do
    @output = TestOutputter.new
    Neospec::Report::Basic.call(
      @results,
      output: @output
    )

    expect(@output.calls.size).to_equal(1)
    expect(
      @output.calls.last
    ).to_equal(<<~STR.chomp)

      Finished in 7.75 seconds

      Results:
        Specs:\t3
        Expectations:\t15
        Failures:\t2

      Failures:
        #{Neospec::Color::RED}oops!#{Neospec::Color::RESET}
          > line 1
          > line 2
          > line 3
          > line 4
          > line 5

        #{Neospec::Color::RED}again, oops!#{Neospec::Color::RESET}
          > line 7
          > line 8
          > line 9
          > line 10
          > line 11
    STR
  end
end

@neospec.describe "Neospec::Report::Basic.formatted_duration" do
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
