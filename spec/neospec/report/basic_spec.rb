@neospec.describe "Neospec::Report::Basic.call" do
  When "we have some results with no failures" do
    @results = Neospec::Results.new

    result_1 = Neospec::Spec::Result.new
    result_1.expectations = 3
    @results.record(result_1)

    result_2 = Neospec::Spec::Result.new
    result_2.expectations = 4
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

      Results:
        Specs:\t2
        Expectations:\t7
    STR
  end

  When "we have some results with failures" do
    @results = Neospec::Results.new

    result_1 = Neospec::Spec::Result.new
    result_1.expectations = 9
    @results.record(result_1)

    result_2 = Neospec::Spec::Result.new
    result_2.expectations = 4
    result_2.failures << Neospec::Spec::Result::Failure.new(
      message: "oops!",
      stack: ["line 1", "line 2", "line 3", "line 4", "line 5", "line 6"]
    )
    @results.record(result_2)

    result_3 = Neospec::Spec::Result.new
    result_3.expectations = 2
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
