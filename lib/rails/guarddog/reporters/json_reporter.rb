require 'json'

module Rails
  module Guarddog
    module Reporters
      class JsonReporter
        def initialize(findings)
          @findings = findings
        end

        def report
          output = {
            timestamp: Time.now.iso8601,
            total_findings: @findings.count,
            severity_breakdown: severity_breakdown,
            findings: @findings.map(&:to_h)
          }
          JSON.pretty_generate(output)
        end

        private

        def severity_breakdown
          @findings.group_by(&:severity).transform_values(&:count)
        end
      end
    end
  end
end
