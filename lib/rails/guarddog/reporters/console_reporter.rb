module Rails
  module Guarddog
    module Reporters
      class ConsoleReporter
        def initialize(findings)
          @findings = findings
        end

        def report
          puts "\n" + "="*60
          puts "Rails GuardDog Security Report".center(60)
          puts "="*60 + "\n"

          if @findings.empty?
            puts "✓ No security issues found!".green
            return
          end

          @findings.group_by(&:severity).each do |severity, findings|
            puts "\n[#{severity.upcase}] (#{findings.count})"
            findings.each do |finding|
              puts "  #{finding.category} — #{finding.message}"
              puts "    #{finding.file}:#{finding.line}"
              puts "    Fix: #{finding.remediation}\n"
            end
          end

          puts "\n" + "="*60
          puts "Total findings: #{@findings.count}"
          puts "="*60 + "\n"
        end
      end
    end
  end
end
