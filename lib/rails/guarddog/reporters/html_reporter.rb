module Rails
  module Guarddog
    module Reporters
      class HtmlReporter
        def initialize(findings)
          @findings = findings
        end

        def report(output_path = "guarddog_report.html")
          html = generate_html
          File.write(output_path, html)
          output_path
        end

        private

        def generate_html
          severity_breakdown = @findings.group_by(&:severity).transform_values(&:count)
          
          html = <<~HTML
            <!DOCTYPE html>
            <html>
            <head>
              <meta charset="UTF-8">
              <title>Rails GuardDog Security Report</title>
              <style>
                * { box-sizing: border-box; }
                body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; margin: 0; padding: 20px; background: #f5f5f5; }
                .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
                h1 { color: #333; margin-top: 0; }
                .stats { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin: 20px 0; }
                .stat-card { padding: 16px; border-radius: 6px; text-align: center; }
                .stat-card.critical { background: #fee; color: #c00; }
                .stat-card.high { background: #fef3cd; color: #856404; }
                .stat-card.medium { background: #cfe2ff; color: #084298; }
                .stat-card.low { background: #d1e7dd; color: #0f5132; }
                .stat-card h3 { margin: 0 0 10px; font-size: 28px; }
                .stat-card p { margin: 0; font-size: 12px; }
                .findings { margin-top: 30px; }
                .finding { border-left: 4px solid #ccc; padding: 16px; margin: 16px 0; background: #fafafa; border-radius: 4px; }
                .finding.critical { border-color: #c00; background: #fee; }
                .finding.high { border-color: #ff9800; background: #fff3cd; }
                .finding.medium { border-color: #2196f3; background: #d1ecf1; }
                .finding.low { border-color: #4caf50; background: #d4edda; }
                .finding-severity { font-weight: bold; font-size: 12px; text-transform: uppercase; }
                .finding-title { font-size: 16px; font-weight: 600; margin: 8px 0; }
                .finding-meta { font-size: 13px; color: #666; margin: 8px 0; }
                .finding-code { background: #f0f0f0; padding: 10px; border-radius: 4px; font-family: monospace; font-size: 12px; margin: 8px 0; overflow-x: auto; }
                .finding-remediation { margin-top: 10px; padding: 10px; background: rgba(0,0,0,0.05); border-radius: 4px; font-size: 13px; }
              </style>
            </head>
            <body>
              <div class="container">
                <h1>🐕 Rails GuardDog Security Report</h1>
                <p>Generated: #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}</p>
                
                <div class="stats">
                  <div class="stat-card critical">
                    <h3>#{severity_breakdown[:critical] || 0}</h3>
                    <p>Critical</p>
                  </div>
                  <div class="stat-card high">
                    <h3>#{severity_breakdown[:high] || 0}</h3>
                    <p>High</p>
                  </div>
                  <div class="stat-card medium">
                    <h3>#{severity_breakdown[:medium] || 0}</h3>
                    <p>Medium</p>
                  </div>
                  <div class="stat-card low">
                    <h3>#{severity_breakdown[:low] || 0}</h3>
                    <p>Low</p>
                  </div>
                </div>

                <div class="findings">
          HTML

          @findings.each do |finding|
            html += %{
              <div class="finding #{finding.severity}">
                <div class="finding-severity">#{finding.severity.upcase}</div>
                <div class="finding-title">#{finding.category} - #{finding.message}</div>
                <div class="finding-meta">#{finding.file}:#{finding.line}</div>
                <div class="finding-code">#{finding.code_snippet}</div>
                <div class="finding-remediation"><strong>Fix:</strong> #{finding.remediation}</div>
              </div>
            }
          end

          html += <<~HTML
                </div>
              </div>
            </body>
            </html>
          HTML

          html
        end
      end
    end
  end
end
