class Neospec
  module Report
    module BuildkiteAnalytics
      def self.call(results, output: File.open("./test-analytics.json", "w"))
        analytics = results.specs.map do |result|
          scope = result.description.split(" ").first.split(".").first.split("#").first
          {
            scope: scope,
            name: result.description,
            identifier: result.description,
            location: result.location,
            file_name: result.file_name,
            result: (result.successful? ? "passed" : "failed"),
            failure_reason: (
              result.failures.map(&:message).join(" ") unless result.successful?
            ),
            history: {
              duration: "%.6f" % [result.duration]
            }
          }
        end

        output.write(analytics.to_json)
      ensure
        output.close
      end
    end
  end
end
