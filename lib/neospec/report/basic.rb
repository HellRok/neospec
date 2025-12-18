class Neospec
  module Report
    module Basic
      def self.call(results, output: $stdout)
        output.puts "\n#{successes(results)}#{failures(results)}"
      end

      def self.successes(results)
        <<~STR.chomp
          Finished in #{formatted_duration(results.duration)}

          Results:
            Specs:\t#{results.specs.size}
            Expectations:\t#{results.expectations}
        STR
      end

      def self.failures(results)
        return if results.successful?

        output = "\n  Failures:\t#{results.failures.size}\n\n"
        output << "Failures:\n"

        results.specs.select { |spec| spec.failures.any? }.each do |spec|
          output << "  #{Neospec::Color::BLUE}== #{spec.description} ==#{Neospec::Color::RESET}\n"

          spec.failures.map do |failure|
            output << "    #{Neospec::Color::RED}-- #{failure.message} --#{Neospec::Color::RESET}\n"
            failure.stack.first(5).each do |location|
              output << "      > #{location}\n"
            end
            output << "\n"
          end
        end

        output.chomp("\n\n")
      end

      def self.formatted_duration(duration)
        if duration < 1
          "#{(duration * 1000).round(2)} milliseconds"
        elsif duration < 60
          "#{duration.round(2)} seconds"
        elsif duration < 3600
          minutes = (duration / 60).to_i
          seconds = (duration % 60).to_i
          "#{minutes} minute#{"s" unless minutes == 1} #{seconds} second#{"s" unless seconds == 1}"
        elsif duration < 86400
          hours = (duration / 3600).to_i
          minutes = ((duration % 3600) / 60).to_i
          "#{hours} hour#{"s" unless hours == 1} #{minutes} minute#{"s" unless minutes == 1}"
        else
          days = (duration / 86400).to_i
          hours = ((duration % 86400) / 3600).to_i
          "#{days} day#{"s" unless days == 1} #{hours} hour#{"s" unless hours == 1}"
        end
      end
    end
  end
end
