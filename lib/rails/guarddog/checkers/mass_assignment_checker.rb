module Rails
  module Guarddog
    module Checkers
      class MassAssignmentChecker < BaseChecker
        def run
          glob_files('app/**/*.rb').each do |file|
            content = File.read(file)
            content.each_line.with_index do |line, idx|
              if line.include?('permit!') || line.include?('permit(:')
                if line.include?('permit!')
                  add_finding(
                    severity: :critical,
                    message: "Mass assignment vulnerability: permit! allows all parameters",
                    file: file,
                    line: idx + 1,
                    snippet: line.strip,
                    remediation: "Use specific permits: permit(:field1, :field2)"
                  )
                end
              end
            end
          end
          findings
        end
      end
    end
  end
end
