module Rails
  module Guarddog
    module Checkers
      class IdorChecker < BaseChecker
        def run
          glob_files('app/controllers/**/*.rb').each do |file|
            content = File.read(file)
            content.each_line.with_index do |line, idx|
              if line.match?(/find\(params\[[:']id[']\]/) && !content.include?('authorize')
                add_finding(
                  severity: :high,
                  message: "Potential IDOR: object accessed by ID without ownership check",
                  file: file,
                  line: idx + 1,
                  snippet: line.strip,
                  remediation: "Add authorization check: authorize @object"
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
