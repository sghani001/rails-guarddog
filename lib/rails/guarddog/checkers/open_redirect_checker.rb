module Rails
  module Guarddog
    module Checkers
      class OpenRedirectChecker < BaseChecker
        def run
          glob_files('app/controllers/**/*.rb').each do |file|
            content = File.read(file)
            content.each_line.with_index do |line, idx|
              if line.match?(/redirect_to\s+params\[:/) || line.match?(/redirect_to\s+request\./)
                add_finding(
                  severity: :high,
                  message: "Potential open redirect: user-controlled redirect URL",
                  file: file,
                  line: idx + 1,
                  snippet: line.strip,
                  remediation: "Whitelist allowed redirect URLs"
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
