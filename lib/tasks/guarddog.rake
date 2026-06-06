namespace :guarddog do
  task :scan => :environment do
    require 'rails/guarddog'
    
    scanner = Rails::Guarddog::Scanner.new
    findings = scanner.run
    
    reporter = Rails::Guarddog::Reporters::ConsoleReporter.new(findings)
    reporter.report
  end

  task :report do
    require 'rails/guarddog'
    
    scanner = Rails::Guarddog::Scanner.new
    findings = scanner.run
    
    html_reporter = Rails::Guarddog::Reporters::HtmlReporter.new(findings)
    path = html_reporter.report("guarddog_report.html")
    puts "✓ HTML report generated: #{path}"
    
    json_reporter = Rails::Guarddog::Reporters::JsonReporter.new(findings)
    File.write("guarddog_report.json", json_reporter.report)
    puts "✓ JSON report generated: guarddog_report.json"
  end

  task :ci do
    require 'rails/guarddog'
    
    scanner = Rails::Guarddog::Scanner.new
    findings = scanner.run
    
    critical = findings.select { |f| f.severity == :critical }
    
    puts Rails::Guarddog::Reporters::JsonReporter.new(findings).report
    
    if critical.any?
      puts "\n❌ CRITICAL VULNERABILITIES FOUND: #{critical.count}"
      exit 1
    else
      puts "\n✓ No critical vulnerabilities"
      exit 0
    end
  end
end
