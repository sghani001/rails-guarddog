module Rails
  module Guarddog
    module Reporters
      class ConsoleReporter
        GREEN  = "\e[32m"
        RED    = "\e[31m"
        YELLOW = "\e[33m"
        CYAN   = "\e[36m"
        BOLD   = "\e[1m"
        RESET  = "\e[0m"

        def initialize(findings)
          @findings = findings
        end

        def report
          puts "\n" + "="*60
          puts "Rails GuardDog Security Report".center(60)
          puts "="*60 + "\n"

          if @findings.empty?
            puts "#{GREEN}✓ No security issues found!#{RESET}"
            return
          end

          @findings.group_by(&:severity).each do |severity, findings|
            color = severity_color(severity)
            puts "\n#{BOLD}#{color}[#{severity.upcase}] (#{findings.count})#{RESET}"
            findings.each do |finding|
              puts "  #{finding.category} — #{finding.message}"
              puts "    #{CYAN}#{finding.file}:#{finding.line}#{RESET}"
              puts "    Fix: #{finding.remediation}\n"
            end
          end

          puts "\n" + "="*60
          puts "#{BOLD}Total findings: #{@findings.count}#{RESET}"
          puts "="*60 + "\n"
        end

        private

        def severity_color(severity)
          case severity.to_s.downcase
          when "critical" then RED
          when "high"     then RED
          when "medium"   then YELLOW
          when "low"      then GREEN
          else RESET
          end
        end
      end
    end
  end
end