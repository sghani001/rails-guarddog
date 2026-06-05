module Rails
  module Guarddog
    module Checkers
      class SqlInjectionChecker < BaseChecker
        def run
          glob_files('app/**/*.rb').each do |file|
            content = File.read(file)
            content.each_line.with_index do |line, idx|
              if line.match?(/\.where\s*\(\s*['"].*#\{/) || line.match?(/\.find_by_sql\s*\(/)
                add_finding(
                  severity: :high,
                  message: "Potential SQL injection: using string interpolation in queries",
                  file: file,
                  line: idx + 1,
                  snippet: line.strip,
                  remediation: "Use parameterized queries: .where('column = ?', value)"
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
