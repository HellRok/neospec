@unit.describe "Neospec::Report::BuildkiteAnalytics.call" do
  When "we have some results with no failures" do
    @suite = Neospec::Suite.new
    @results = Neospec::Results.new(suites: [@suite])

    spec_1 = Neospec::Spec.new(description: "Class#spec", block: -> {}, stack: ["spec_1:1"])
    spec_1.result.start = 1
    spec_1.result.finish = 5
    @suite.specs << spec_1

    spec_2 = Neospec::Spec.new(description: "Class.method", block: -> {}, stack: ["spec_2:1"])
    spec_2.result.failures = [Neospec::Spec::Result::Failure.new(stack: "", message: "a test failure")]
    spec_2.result.start = 6
    spec_2.result.finish = 9.5
    @suite.specs << spec_2
  end

  Then "it outputs information" do
    @output = TestOutputter.new
    Neospec::Report::BuildkiteAnalytics.call(@results, output: @output)

    expect(@output.calls.size).to_equal(1)
    expect(
      JSON.parse(@output.calls.last)
    ).to_equal(
      [
        {
          "scope" => "Class",
          "name" => "Class#spec",
          "identifier" => "Class#spec",
          "location" => "spec_1:1",
          "file_name" => "spec_1",
          "result" => "passed",
          "failure_reason" => nil,
          "history" => {
            "duration" => "4.000000"
          }
        },
        {
          "scope" => "Class",
          "name" => "Class.method",
          "identifier" => "Class.method",
          "location" => "spec_2:1",
          "file_name" => "spec_2",
          "result" => "failed",
          "failure_reason" => "a test failure",
          "history" => {
            "duration" => "3.500000"
          }
        }
      ]
    )
  end
end
