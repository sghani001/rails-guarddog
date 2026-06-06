module Rails
  module Guarddog
    module Checkers
      class XssChecker < BaseChecker
        def run
          glob_files('app/views/**/*.erb').each do |file|
            content = File.read(file)
            content.each_line.with_index do |line, idx|
              if xss_vulnerable?(line)
                add_finding(
                  severity: :high,
                  message: "Potential XSS vulnerability: unescaped output detected",
                  file: file,
                  line: idx + 1,
                  snippet: line.strip,
                  remediation: "Use <%= h() %> or sanitize() instead of raw/html_safe"
                )
              end
            end
          end
          findings
        end

        private

        def xss_vulnerable?(line)
          # <%== is Rails' raw output (alias for raw())
          return true if line.match?(/<%==/)

          # raw() helper explicitly disables escaping
          return true if line.match?(/<%=.*\braw\s*\(/)

          # .html_safe bypasses escaping
          return true if line.match?(/<%=.*\.html_safe/)

          # concat with raw content
          return true if line.match?(/<%=.*content_tag.*html_safe/)

          false
        end
      end
    end
  end
end
