module Rails
  module Guarddog
    module Checkers
      class SecretsChecker < BaseChecker
        PATTERNS = [
          /api[_-]?key\s*[=:]\s*['"][^'"]+['"]/i,
          /secret[_-]?key\s*[=:]\s*['"][^'"]+['"]/i,
          /password\s*[=:]\s*['"][^'"]+['"]/i,
          /token\s*[=:]\s*['"][^'"]+['"]/i
        ]

        def run
          %w[*.rb *.yml .env .env.local].each do |pattern|
            glob_files("**/{#{pattern}}").each do |file|
              next if file.include?('node_modules') || file.include?('vendor')
              content = File.read(file) rescue next
              content.each_line.with_index do |line, idx|
                PATTERNS.each do |pattern|
                  if line.match?(pattern) && !line.strip.start_with?('#')
                    add_finding(
                      severity: :critical,
                      message: "Hardcoded secret detected",
                      file: file,
                      line: idx + 1,
                      remediation: "Use ENV variables or Rails credentials"
                    )
                  end
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
