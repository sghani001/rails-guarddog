module Rails
  module Guarddog
    module Checkers
      class DosChecker < BaseChecker
        def run
          glob_files('app/**/*.rb').each do |file|
            content = File.read(file)
            content.each_line.with_index do |line, idx|
              # Check for unbounded queries
              if line.match?(/\.where\(.*\)\.all/) || line.match?(/\.all\s*$/)
                add_finding(
                  severity: :high,
                  message: "Potential DoS: unbounded database query without limit",
                  file: file,
                  line: idx + 1,
                  snippet: line.strip,
                  remediation: "Add .limit() to control result size"
                )
              end
              # Check for regex vulnerabilities
              if line.match?(/\/.+\*\+.*\*\+.+\//) || line.match?(/match\?.*\(.+\*\+/)
                add_finding(
                  severity: :high,
                  message: "Potential ReDoS vulnerability: dangerous regex pattern",
                  file: file,
                  line: idx + 1,
                  snippet: line.strip,
                  remediation: "Simplify regex or use timeout mechanisms"
                )
              end
            end
          end
          findings
        end
      end
    end
  end
end
