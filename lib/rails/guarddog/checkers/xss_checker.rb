module Rails
  module Guarddog
    module Checkers
      class XssChecker < BaseChecker
        def run
          glob_files('app/views/**/*.erb').each do |file|
            content = File.read(file)
            content.each_line.with_index do |line, idx|
              if line.include?('<%=') && (line.include?('params') || line.include?('@')) && !line.include?('sanitize') && !line.include?('h(')
                add_finding(
                  severity: :high,
                  message: "Potential XSS vulnerability: unsanitized user input in view",
                  file: file,
                  line: idx + 1,
                  snippet: line.strip,
                  remediation: "Use <%= h() %> or sanitize() helper"
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
